Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96DC7B89BB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbjJDS2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244210AbjJDS2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:28:36 -0400
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EE49E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:28:30 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 34923 invoked from network); 4 Oct 2023 20:28:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1696444107; bh=9WqA8RBus0lT/tlmpFJJ73tod3YptX81Tc2dYpc1LK4=;
          h=From:To:Cc:Subject;
          b=h3Fqop8Q6R+02M6NAU7WmxsvBqSVKRWybFa4bVqNvp8gmCfipWX6UD+KJsDnzZGbL
           HlA8bbigIsqnvpHJ3pFfMuA5731n3g67RC6UZaL1bHsR1nAdbDGlFDOZWZpYbb+26X
           4c/PWDoFdCtktw/GOYywu07X0TLQSX3JCjYaWJ+o=
Received: from 89-64-13-175.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.175])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <enc0der@gmail.com>; 4 Oct 2023 20:28:27 +0200
Date:   Wed, 4 Oct 2023 20:28:26 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     enc0der <enc0der@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>
Subject: Re: rt8000usb driver issue (maybe interaction with other drivers)
Message-ID: <20231004182826.GA411448@wp.pl>
References: <CAEXpi5Rd6Y4umKOWRsCjX0kit=W5ZrVhn=MuRkyvJPwmjjDVnA@mail.gmail.com>
 <ZRj_ovMi-Xbb8i-D@debian.me>
 <20231002185053.GB402943@wp.pl>
 <CAEXpi5StYwujiTaH2_5PE9Hg_cgzAEtBuFxfgVxEJvbqRNv_4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXpi5StYwujiTaH2_5PE9Hg_cgzAEtBuFxfgVxEJvbqRNv_4A@mail.gmail.com>
X-WP-MailID: f0179e23565c96ae6547a30aa0eda1e9
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [IYOV]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Oct 03, 2023 at 09:34:32PM -0400, enc0der wrote:
> Hello Stanislaw!
> 
> On Mon, Oct 2, 2023 at 2:50 PM Stanislaw Gruszka <stf_xl@wp.pl> wrote:
> >
> > Is possible that this is rt2800usb or usb host driver issue. But without
> > full logs we can not be sure.
> 
> Okay, I was able to use dmesg -w before it kernel panic'd to grab some
> additional details, first this is when I plug in th USB WiFi adapter
> but I have it not automatically connect.  In this state, it will not
> kernel panic:

<snip>
> [ 1542.242112] BUG: scheduling while atomic: ksoftirqd/3/29/0x00000103
> [ 1542.248587] Modules linked in: rt2800usb(E) rt2x00usb(E)
> rt2800lib(E) rt2x00lib(E) mac80211(E) cfg80211(E) nvidia_modeset(OE)
> fuse(E) lzo_rle(E) lzo_compress(E) zram(E) ramoops(E) reed_solomon(E)
> loop(E) snd_soc_tegra186_asrc(E) snd_soc_tegra210_ope(E)
> snd_soc_tegra186_arad(E) snd_soc_tegra186_dspk(E)
> snd_soc_tegra210_iqc(E) aes_ce_blk(E) crypto_simd(E) cryptd(E)
> snd_soc_tegra210_mvc(E) snd_soc_tegra210_afc(E) aes_ce_cipher(E)
> snd_soc_tegra210_dmic(E) snd_soc_tegra210_adx(E) ghash_ce(E)
> snd_soc_tegra210_amx(E) sha2_ce(E) snd_soc_tegra210_i2s(E)
> snd_soc_tegra210_mixer(E) snd_soc_tegra210_admaif(E) sha256_arm64(E)
> snd_soc_tegra210_sfc(E) snd_soc_tegra_pcm(E) hid_ite(E) sha1_ce(E)
> input_leds(E) spidev(E) snd_soc_tegra210_adsp(E)
> snd_soc_tegra_machine_driver(E) snd_soc_spdif_tx(E)
> snd_soc_tegra_utils(E) snd_soc_simple_card_utils(E)
> snd_hda_codec_hdmi(E) snd_soc_tegra210_ahub(E) nvadsp(E)
> userspace_alert(E) snd_hda_tegra(E) tegra_bpmp_thermal(E)
> tegra210_adma(E) nv_imx219(E) snd_hda_codec(E)
> [ 1542.248665]  snd_hda_core(E) spi_tegra114(E) nvidia(OE)
> binfmt_misc(E) ina3221(E) pwm_fan(E) nvgpu(E) nvmap(E) ip_tables(E)
> x_tables(E) [last unloaded: mtd]
> [ 1542.248686] CPU: 3 PID: 29 Comm: ksoftirqd/3 Tainted: G        W
> OE     5.10.120-tegra #1
> [ 1542.248687] Hardware name: Unknown NVIDIA Orin Nano Developer
> Kit/NVIDIA Orin Nano Developer Kit, BIOS 4.1-33958178 08/01/2023
> [ 1542.248690] Call trace:
> [ 1542.248702]  dump_backtrace+0x0/0x1d0
> [ 1542.248705]  show_stack+0x30/0x40
> [ 1542.248712]  dump_stack+0xd8/0x138
> [ 1542.248717]  __schedule_bug+0x78/0x90
> [ 1542.248722]  __schedule+0x844/0x910
> [ 1542.248724]  schedule+0x78/0x110
> [ 1542.248727]  schedule_timeout+0x184/0x340
> [ 1542.248731]  nvhost_syncpt_wait_timeout+0x450/0x720
> [ 1542.248733]  nvhost_syncpt_wait_timeout_ext+0xf4/0x120
> [ 1542.248738]  tegra_se_channel_submit_gather.isra.0+0x160/0x440
> [ 1542.248740]  tegra_se_ccm_compute_auth+0x2d8/0x650
> [ 1542.248743]  tegra_se_aes_ccm_encrypt+0x6c/0x150
> [ 1542.248746]  crypto_aead_encrypt+0x38/0x50
> [ 1542.248768]  aead_encrypt+0x130/0x180 [mac80211]
> [ 1542.248782]  ieee80211_crypto_ccmp_encrypt+0x1f8/0x270 [mac80211]
> [ 1542.248793]  ieee80211_txq_schedule_start+0xae4/0xc10 [mac80211]
Here is the issue. We send the frames with spin_lock taken, in such
case no sleep (i.e. schedule() call) is allowed. Some function from 
tegra/nvhost is actually sleeping, hence the bug.

As already pointed Thorsten, those tegra_/nvhost_ are proprietary functions,
which are not included in the upstream linux kernel, so we can not fix them.

However I can advice you to detach those from crypto_aead_encrypt,
this should be doable. At worst your will need to  recompile your
kernel with those crypto offload engines disabled, but perhaps
this can be configured dynamically.

Regards
Stanislaw
