Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5FD797793
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbjIGQ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbjIGQZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:25:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C13A59C3;
        Thu,  7 Sep 2023 09:21:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B859C433B8;
        Thu,  7 Sep 2023 09:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694079052;
        bh=TiT32MSj3JgzYk5BqsCOQEiIdDx5M2GTmRAd61MVr/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NtmptFt7CZxUCwzDgfsKsOiT32m5Si5FKAR0ogW+EzRFOCFC0FgYO2FtoYoIp7YpM
         zbn7CXxNH0mtEw+3N6P0ogEhTQ6+cXJsHqdaqMQ2w6I9fvmyQbiIy2Gbh68h69K9LY
         UR627ly2qJQkQUS2mmYA4J4R1uU8Cc87wiiJ48bQ=
Date:   Thu, 7 Sep 2023 10:30:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.5 11/34] modules: only allow symbol_get of
 EXPORT_SYMBOL_GPL modules
Message-ID: <2023090719-virtuous-snowflake-d015@gregkh>
References: <20230904182948.594404081@linuxfoundation.org>
 <20230904182949.104100132@linuxfoundation.org>
 <20230907084135.02d97441@mir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907084135.02d97441@mir>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 08:41:35AM +0200, Stefan Lippers-Hollmann wrote:
> Hi
> 
> On 2023-09-04, Greg Kroah-Hartman wrote:
> > 6.5-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Christoph Hellwig <hch@lst.de>
> >
> > commit 9011e49d54dcc7653ebb8a1e05b5badb5ecfa9f9 upstream.
> >
> > It has recently come to my attention that nvidia is circumventing the
> > protection added in 262e6ae7081d ("modules: inherit
> > TAINT_PROPRIETARY_MODULE") by importing exports from their proprietary
> > modules into an allegedly GPL licensed module and then rexporting them.
> >
> > Given that symbol_get was only ever intended for tightly cooperating
> > modules using very internal symbols it is logical to restrict it to
> > being used on EXPORT_SYMBOL_GPL and prevent nvidia from costly DMCA
> > Circumvention of Access Controls law suites.
> >
> > All symbols except for four used through symbol_get were already exported
> > as EXPORT_SYMBOL_GPL, and the remaining four ones were switched over in
> > the preparation patches.
> 
> This patch, as part of v6.5.2, breaks the in-kernel ds3000 module
> (for a TeVii s480 v2 DVB-S2 card, which is a PCIe card attaching two
> onboard TeVii s660 cards via an onboard USB2 controller (MCS9990),
> https://www.linuxtv.org/wiki/index.php/TeVii_S480) from loading.

This is also broken in Linus's tree, right?

> [    2.896589] dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
> [    2.901085] failing symbol_get of non-GPLONLY symbol ds3000_attach.
> [    2.901089] DVB: Unable to find symbol ds3000_attach()

This is odd, where is that call coming from?  I don't see any call to
symbol_get in the dvb code, where is this happening?

Anyway, does the patch below fix this?

thanks,

greg k-h

----------------

diff --git a/drivers/media/dvb-frontends/ds3000.c b/drivers/media/dvb-frontends/ds3000.c
index 20fcf31af165..515aa7c7baf2 100644
--- a/drivers/media/dvb-frontends/ds3000.c
+++ b/drivers/media/dvb-frontends/ds3000.c
@@ -859,7 +859,7 @@ struct dvb_frontend *ds3000_attach(const struct ds3000_config *config,
 	ds3000_set_voltage(&state->frontend, SEC_VOLTAGE_OFF);
 	return &state->frontend;
 }
-EXPORT_SYMBOL(ds3000_attach);
+EXPORT_SYMBOL_GPL(ds3000_attach);
 
 static int ds3000_set_carrier_offset(struct dvb_frontend *fe,
 					s32 carrier_offset_khz)
