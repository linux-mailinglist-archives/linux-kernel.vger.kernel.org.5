Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514E380B5DB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 19:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjLISUx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 9 Dec 2023 13:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjLISUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 13:20:51 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42405E1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 10:20:56 -0800 (PST)
Received: from [192.168.2.4] (51b690cd.dsl.pool.telekom.hu [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006FA9A.000000006574B003.0011E711; Sat, 09 Dec 2023 19:20:51 +0100
Message-ID: <4fccb5ae252ff8efd8b5e760b4a6852ff76c99b5.camel@irl.hu>
Subject: Re: [PATCH 11/16] ASoC: tas2781: use 0 as default prog/conf index
From:   Gergo Koteles <soyer@irl.hu>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Date:   Sat, 09 Dec 2023 19:20:50 +0100
In-Reply-To: <a07270d1-ef63-4558-83aa-223b97b1a93e@sirena.org.uk>
References: <cover.1701906455.git.soyer@irl.hu>
         <88229933b7aaf0777cbe611979712e4e144b1ca1.1701906455.git.soyer@irl.hu>
         <a07270d1-ef63-4558-83aa-223b97b1a93e@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-12-07 at 18:28 +0000, Mark Brown wrote:
> On Thu, Dec 07, 2023 at 01:04:27AM +0100, Gergo Koteles wrote:
> 
> > Invalid indexes are not the best default values.
> 
> I'm guessing this is just fallout from the previous (not really
> explained patch)?  Is there perhaps some bootstrapping issue here with
> ensuring that the program and configuration get written to the device if
> the user doesn't explicitly select something in a control?

I added the >0 checks because I encountered a NULL pointer dereference.

Because
tasdevice_init sets
tas_priv->cur_prog = -1
tas_priv->cur_conf = -1

tasdev_fw_ready calls tasdevice_prmg_load(tas_priv, 0) which sets
tasdevice[i]->prg_no = 0

Then the playback hook calls
tasdevice_tuning_switch(tas_hda->priv, 0)
tasdevice_select_tuningprm_cfg(tas_priv, cur_prog (-1), cur_conf (-1),
profile_cfg_id (0));

tasdevice_select_tuningprm_cfg checks
if (tas_priv->tasdevice[i].cur_prog (0) != prm_no (-1)
and tries to load the program from
program = &(tas_fmw->programs[prm_no (-1)]);
tasdevice_load_data(tas_priv, &(program->dev_data));

I think the intention was to load the first program, first
configuration, first profile. And that's the safe thing to do.
So I expressed that with this commit.

Yes, I need to write much better commit messages.

