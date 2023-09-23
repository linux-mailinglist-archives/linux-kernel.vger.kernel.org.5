Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3337AC474
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 20:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjIWSfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 14:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIWSft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 14:35:49 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7CF11D
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:35:43 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:7e5d:5300::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id AD6FDAEB;
        Sat, 23 Sep 2023 11:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1695494142;
        bh=rwE1Lu/ZlbFOsDCqkNOs8+1lQ1FDY2v7Q4vqEN/jrBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyM0mCqyaWhY+q1iTvFtQbZGDA6R3yff1e+sXXD14xtrZyGcAa0sH0b2ACqEmNVHz
         MgkGQMAp8bgmCFyzuUFvmoYn0lyrK+oGaHaRVcpuscuElJLPE2KCh+zalFPJ8u9N+D
         nuBoRfX6B0dfAQ68B5pkDQcc3+JZ6pIvkXanAu94=
Date:   Sat, 23 Sep 2023 11:35:41 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] regulator: userspace-consumer: Retrieve supplies
 from DT
Message-ID: <f8a805da-2897-4730-a005-e89027e72501@hatter.bewilderbeest.net>
References: <20230922090330.1570350-1-naresh.solanki@9elements.com>
 <53bf617a-0a47-4c51-9738-6f6e6e520d99@hatter.bewilderbeest.net>
 <6da614bf-c35c-4bae-84d9-fb9641dcbe59@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6da614bf-c35c-4bae-84d9-fb9641dcbe59@hatter.bewilderbeest.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 05:16:12AM PDT, Zev Weiss wrote:
>On Sat, Sep 23, 2023 at 05:02:59AM PDT, Zev Weiss wrote:
>>Hi Naresh,
>>
>>This looks basically alright to me, though a few suggested tweaks 
>>below...
>>
>>On Fri, Sep 22, 2023 at 02:03:29AM PDT, Naresh Solanki wrote:
>>>From: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>
>>>Instead of hardcoding a single supply, retrieve supplies from DT.
>>>
>>>Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>---
>>>drivers/regulator/userspace-consumer.c | 43 ++++++++++++++++++++++++--
>>>1 file changed, 40 insertions(+), 3 deletions(-)
>>>
>>>diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
>>>index 97f075ed68c9..a3d3e1e6ca74 100644
>>>--- a/drivers/regulator/userspace-consumer.c
>>>+++ b/drivers/regulator/userspace-consumer.c
>>>@@ -115,11 +115,32 @@ static const struct attribute_group attr_group = {
>>>	.is_visible =  attr_visible,
>>>};
>>>
>>>+#define SUPPLY_SUFFIX "-supply"
>>>+#define SUPPLY_SUFFIX_LEN 7
>>
>>I think 'strlen(SUPPLY_SUFFIX)' would be preferable to a numeric 
>>literal here; it's less fragile and the compiler can evaluate it at 
>>compile-time anyway (not that it's likely to be performance-critical 
>>in this context I'd expect).
>>
>>>+
>>>+static int get_num_supplies(struct platform_device *pdev)
>>>+{
>>>+	struct  property *prop;
>>>+	int num_supplies = 0;
>>>+
>>>+	for_each_property_of_node(pdev->dev.of_node, prop) {
>>>+		const char *prop_name = prop->name;
>>>+		int len = strlen(prop_name);
>>>+
>>>+		if (len > SUPPLY_SUFFIX_LEN &&
>>>+		    strcmp(prop_name + len - SUPPLY_SUFFIX_LEN, SUPPLY_SUFFIX) == 0) {
>>>+			num_supplies++;
>>>+		}
>>
>>Preferred coding style is to omit braces around single-line 'if' blocks.
>>
>>>+	}
>>>+	return num_supplies;
>>>+}
>>>+
>>>static int regulator_userspace_consumer_probe(struct platform_device *pdev)
>>>{
>>>	struct regulator_userspace_consumer_data tmpdata;
>>>	struct regulator_userspace_consumer_data *pdata;
>>>	struct userspace_consumer_data *drvdata;
>>>+	struct  property *prop;
>>
>>Looks like there's an extra space after 'struct' here.
>>
>>>	int ret;
>>>
>>>	pdata = dev_get_platdata(&pdev->dev);
>>>@@ -131,11 +152,27 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
>>>		memset(pdata, 0, sizeof(*pdata));
>>>
>>>		pdata->no_autoswitch = true;
>>>-		pdata->num_supplies = 1;
>>>-		pdata->supplies = devm_kzalloc(&pdev->dev, sizeof(*pdata->supplies), GFP_KERNEL);
>>>+		pdata->num_supplies = get_num_supplies(pdev);
>>>+
>>>+		pdata->supplies = devm_kzalloc(&pdev->dev, pdata->num_supplies *
>>>+					       sizeof(*pdata->supplies), GFP_KERNEL);
>>
>>Splitting the multiplication across two lines like that isn't great 
>>readability-wise IMO; it might be better to just assign it to a 
>>variable and use that instead to make things fit nicely.
>>
>>>		if (!pdata->supplies)
>>>			return -ENOMEM;
>>>-		pdata->supplies[0].supply = "vout";
>>>+
>>>+		for_each_property_of_node(pdev->dev.of_node, prop) {
>>>+			const char *prop_name = prop->name;
>>>+			int len = strlen(prop_name);
>>>+
>>>+			if (len > SUPPLY_SUFFIX_LEN &&
>>>+			    strcmp(prop_name + len - SUPPLY_SUFFIX_LEN, SUPPLY_SUFFIX) == 0) {
>>
>>Rather than duplicating this suffix-checking code, how about 
>>factoring out a helper function like prop_is_supply() or something 
>>to use both here and in get_num_supplies()?
>>
>>Or actually to make it integrate here a little more nicely, you 
>>could have something like 'size_t prop_supply_name(char*)', 
>>returning zero
>
>Or rather prop_supply_name_len(), to make the name a bit more accurate.
>
>>if it doesn't end with "-supply", and the length of the name before 
>>the suffix if it does, so that get_num_supplies() could use it as a 
>>boolean and the code below could use the length to determine the 
>>allocation size.
>>
>>>+				char *supply_name = devm_kzalloc(&pdev->dev,
>>>+								 len - SUPPLY_SUFFIX_LEN + 1,
>>>+								 GFP_KERNEL);
>>>+				strscpy(supply_name, prop_name, len - SUPPLY_SUFFIX_LEN);
>>>+				supply_name[len - SUPPLY_SUFFIX_LEN] = '\0';
>
>Also, kstrndup() would be a cleaner replacement for these lines, 
>though then the cleanup would get messy, and sadly a devm_kstrndup() 
>doesn't currently exist -- maybe it'd be worth adding separately?  Or 
>alternately you could just use devm_kstrdup() and then truncate it by 
>inserting a '\0'.
>
>>>+				pdata->supplies[0].supply = supply_name;
>>>+			}
>>>+		}
>>>	}
>>>
>>>	if (pdata->num_supplies < 1) {
>>>
>>>base-commit: 451e85e29c9d6f20639d4cfcff4b9dea280178cc
>>>-- 
>>>2.41.0
>>>

Oh, and sorry for the barrage of self-replies here, but one more thing: 
I think we should also update the regulator-output DT binding to reflect 
the added flexibility that this provides.


Zev

