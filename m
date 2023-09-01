Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFB878FAC4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346274AbjIAJ1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjIAJ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:27:33 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4F710E7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 02:27:29 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:3f:e471:aa00::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 66B40162;
        Fri,  1 Sep 2023 02:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1693560449;
        bh=lWtupZVh/hNglyvB+QPBKJ+SSe9s9P140z0bzxoSn8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PXraO4BC1W1WtEFsmxZfj9q1UpgMjhJonDA+Ln+bz2DXlE2MLIX6hAvFmqiyXLYNz
         l7HsuCqEJNODFBHesM1dZCOpqzqazNJ9OPVzzV6iuJjg9ENYNOieytwjseO3ez2ZWU
         HnBF5OkZ7C1uRP4q9ITOZqbSg1+a7j61Sq2EOp8E=
Date:   Fri, 1 Sep 2023 02:27:28 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] regulator: userspace-consumer: Add regulator event
 support
Message-ID: <5000a233-e992-455a-bca3-79aaa8713ff4@hatter.bewilderbeest.net>
References: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
 <20230831121412.2359239-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230831121412.2359239-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 05:14:09AM PDT, Naresh Solanki wrote:
>Add sysfs attribute to track regulator events received from regulator
>notifier block handler.
>
>Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>---
> drivers/regulator/userspace-consumer.c | 54 +++++++++++++++++++++++++-
> 1 file changed, 53 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
>index 97f075ed68c9..a936661d99cd 100644
>--- a/drivers/regulator/userspace-consumer.c
>+++ b/drivers/regulator/userspace-consumer.c
>@@ -29,6 +29,10 @@ struct userspace_consumer_data {
>
> 	int num_supplies;
> 	struct regulator_bulk_data *supplies;
>+
>+	struct kobject *kobj;
>+	struct notifier_block nb;
>+	unsigned long events;
> };
>
> static ssize_t name_show(struct device *dev,
>@@ -89,12 +93,30 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
> 	return count;
> }
>
>+static DEFINE_SPINLOCK(events_lock);
>+
>+static ssize_t events_show(struct device *dev,
>+			   struct device_attribute *attr, char *buf)
>+{
>+	struct userspace_consumer_data *data = dev_get_drvdata(dev);
>+	unsigned long e;
>+
>+	spin_lock(&events_lock);
>+	e = data->events;
>+	data->events = 0;

I still don't think this is a good solution for the problem.

I for one frequently examine things in sysfs using shell commands like 
'cat' and 'grep' and such, and I suspect I'm (very, very) far from alone 
in that.  With this design a user doing that could cause a monitoring 
daemon to miss events that it was expecting to receive via this file.  

I don't think we should be creating sysfs files that are secretly land 
mines that allow a curious user innocently peeking around in sysfs doing 
(they think) read-only operations to break things for other programs 
using those files.


Zev

