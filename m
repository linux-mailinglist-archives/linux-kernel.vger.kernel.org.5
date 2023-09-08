Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35835798311
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbjIHHHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjIHHHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:07:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790AD19A8;
        Fri,  8 Sep 2023 00:07:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECDCC433C8;
        Fri,  8 Sep 2023 07:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694156831;
        bh=Mvfg40PvNKlM7cqJHpippOSPHXHi3Vb5ApnlY5WBQQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ohsZscb/kc/cKPqnlhi2NGu8Lh/Rnv66j06ZXqF/7Im+tQNzzhRVnYmExDcGWsVX4
         AcZjuFUqbKuTi6bkI3wo0uX4+fisE0JHnpRTLj6po15Z40zb3/OabIfEzpSVOoI5gU
         LqLKMs7qzswNhzaT9LtD8hugtUTsO4bROL6s7yyA=
Date:   Fri, 8 Sep 2023 08:07:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.5 11/34] modules: only allow symbol_get of
 EXPORT_SYMBOL_GPL modules
Message-ID: <2023090841-antitrust-reword-d6bc@gregkh>
References: <20230904182948.594404081@linuxfoundation.org>
 <20230904182949.104100132@linuxfoundation.org>
 <20230907084135.02d97441@mir>
 <2023090719-virtuous-snowflake-d015@gregkh>
 <20230907221737.07f12f38@mir>
 <2023090848-chastise-paycheck-6d4d@gregkh>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ei/y4dglsX7VnWMK"
Content-Disposition: inline
In-Reply-To: <2023090848-chastise-paycheck-6d4d@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ei/y4dglsX7VnWMK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 08, 2023 at 07:46:56AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Sep 07, 2023 at 10:17:37PM +0200, Stefan Lippers-Hollmann wrote:
> > Hi
> > 
> > On 2023-09-07, Greg Kroah-Hartman wrote:
> > > On Thu, Sep 07, 2023 at 08:41:35AM +0200, Stefan Lippers-Hollmann wrote:
> > > > On 2023-09-04, Greg Kroah-Hartman wrote:
> > > > > 6.5-stable review patch.  If anyone has any objections, please let me know.
> > > > >
> > > > > ------------------
> > > > >
> > > > > From: Christoph Hellwig <hch@lst.de>
> > > > >
> > > > > commit 9011e49d54dcc7653ebb8a1e05b5badb5ecfa9f9 upstream.
> > > > >
> > > > > It has recently come to my attention that nvidia is circumventing the
> > > > > protection added in 262e6ae7081d ("modules: inherit
> > > > > TAINT_PROPRIETARY_MODULE") by importing exports from their proprietary
> > > > > modules into an allegedly GPL licensed module and then rexporting them.
> > > > >
> > > > > Given that symbol_get was only ever intended for tightly cooperating
> > > > > modules using very internal symbols it is logical to restrict it to
> > > > > being used on EXPORT_SYMBOL_GPL and prevent nvidia from costly DMCA
> > > > > Circumvention of Access Controls law suites.
> > > > >
> > > > > All symbols except for four used through symbol_get were already exported
> > > > > as EXPORT_SYMBOL_GPL, and the remaining four ones were switched over in
> > > > > the preparation patches.
> > > >
> > > > This patch, as part of v6.5.2, breaks the in-kernel ds3000 module
> > > > (for a TeVii s480 v2 DVB-S2 card, which is a PCIe card attaching two
> > > > onboard TeVii s660 cards via an onboard USB2 controller (MCS9990),
> > > > https://www.linuxtv.org/wiki/index.php/TeVii_S480) from loading.
> > >
> > > This is also broken in Linus's tree, right?
> > 
> > Yes, HEAD as of 6.5.0-12145-g4a0fc73da97e is affected just as well.
> 
> Ok, good, thanks for confirming.
> 
> > > > [    2.896589] dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
> > > > [    2.901085] failing symbol_get of non-GPLONLY symbol ds3000_attach.
> > > > [    2.901089] DVB: Unable to find symbol ds3000_attach()
> > >
> > > This is odd, where is that call coming from?  I don't see any call to
> > > symbol_get in the dvb code, where is this happening?
> > >
> > > Anyway, does the patch below fix this?
> > 
> > That change alone only moves the issue down to ts2020_attach().
> > 
> > $ dmesg | grep -i -e dvb -e gpl -e symbol
> > [    1.464876] usb 3-1: Product: DVBS2BOX
> > [    1.482143] usb 5-1: Product: DVBS2BOX
> > [    3.692647] dvb-usb: found a 'TeVii S660 USB' in cold state, will try to load a firmware
> > [    3.692951] dvb-usb: downloading firmware from file 'dvb-usb-s660.fw'
> > [    3.860571] dvb-usb: found a 'TeVii S660 USB' in warm state.
> > [    3.860615] dvb-usb: will pass the complete MPEG2 transport stream to the software demuxer.
> > [    3.860944] dvbdev: DVB: registering new adapter (TeVii S660 USB)
> > [    4.097144] dvb-usb: MAC address: 00:18:XX:XX:XX:XX
> > [    4.097272] dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
> > [    4.111792] failing symbol_get of non-GPLONLY symbol ts2020_attach.
> > [    4.111795] DVB: Unable to find symbol ts2020_attach()
> > [    4.112759] usb 3-1: DVB: registering adapter 0 frontend 0 (Montage Technology DS3000)...
> > [    4.112764] dvbdev: dvb_create_media_entity: media entity 'Montage Technology DS3000' registered.
> > [    4.138938] dvb-usb: schedule remote query interval to 150 msecs.
> > [    4.138942] dvb-usb: TeVii S660 USB successfully initialized and connected.
> > [    4.138988] dvb-usb: found a 'TeVii S660 USB' in cold state, will try to load a firmware
> > [    4.139016] dvb-usb: downloading firmware from file 'dvb-usb-s660.fw'
> > [    4.292614] dvb-usb: found a 'TeVii S660 USB' in warm state.
> > [    4.292679] dvb-usb: will pass the complete MPEG2 transport stream to the software demuxer.
> > [    4.293075] dvbdev: DVB: registering new adapter (TeVii S660 USB)
> > [    4.538876] dvb-usb: MAC address: 00:18:XX:XX:XX:XX
> > [    4.539113] dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
> > [    4.543738] failing symbol_get of non-GPLONLY symbol ts2020_attach.
> > [    4.546349] failing symbol_get of non-GPLONLY symbol ts2020_attach.
> > [    4.546354] DVB: Unable to find symbol ts2020_attach()
> > [    4.548643] usb 5-1: DVB: registering adapter 1 frontend 0 (Montage Technology DS3000)...
> > [    4.548650] dvbdev: dvb_create_media_entity: media entity 'Montage Technology DS3000' registered.
> > [    4.549970] dvb-usb: schedule remote query interval to 150 msecs.
> > [    4.549973] dvb-usb: TeVii S660 USB successfully initialized and connected.
> > [    7.830408] ds3000_firmware_ondemand: Waiting for firmware upload (dvb-fe-ds3000.fw)...
> > [    8.367600] ds3000_firmware_ondemand: Waiting for firmware upload (dvb-fe-ds3000.fw)...
> > 
> > Extending this to approach to ts2020_attach() does fix the problem
> > for me. Searching the web for "failing symbol_get of non-GPLONLY
> > symbol" suggests that there might be further instances within the
> > DVB subsystem https://syzkaller.appspot.com/x/log.txt?x=11faa1eda80000
> > (this was merely gathered by a passive web search, I have no contact
> > to the poster or any further information about it).
> 
> Ugh, it looks like everyone that calls dvb_attach() is going to be
> affected.  I can make up a patch for this later today, unless Christoph
> beats me to it :)
> 
> Also, in commit 8f569c0b4e6b ("media: dvb-core: add helper functions for
> I2C binding"), way back in 2018, it says no one should be using this
> function anymore, but given I see over 700 uses of it, that's obviously
> not changing any time soon :(

And it's over 130 symbols, attached, I'll figure out a way to script
this...


--ei/y4dglsX7VnWMK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=symbol_list

as102_attach
ascot2e_attach
atbm8830_attach
au8522_attach
bcm3510_attach
cx22700_attach
cx22702_attach
cx24110_attach
cx24113_attach
cx24116_attach
cx24117_attach
cx24120_attach
cx24123_attach
cxd2820r_attach
cxd2841er_attach_s
cxd2841er_attach_t_c
cxd2880_attach
ddbridge_dummy_fe_qam_attach
dib0070_attach
dib0090_fw_register
dib0090_register
dib3000mb_attach
dib3000mc_attach
dib7000m_attach
dib7000p_attach
dib8000_attach
dib9000_attach
drx39xxj_attach
drxd_attach
drxk_attach
ds3000_attach
dst_attach
dst_ca_attach
dvb_pll_attach
ec100_attach
fc0011_attach
fc0012_attach
fc0013_attach
gp8psk_fe_attach
helene_attach
helene_attach_s
horus3a_attach
isl6405_attach
isl6421_attach
isl6423_attach
itd1000_attach
ix2505v_attach
l64781_attach
lg2160_attach
lgdt3305_attach
lgdt3306a_attach
lgdt330x_attach
lgs8gxx_attach
lnbh24_attach
lnbh25_attach
lnbp21_attach
lnbp22_attach
m88ds3103_attach
m88rs2000_attach
max2165_attach
mb86a16_attach
mb86a20s_attach
mc44s803_attach
microtune_attach
mt2060_attach
mt2063_attach
mt2131_attach
mt2266_attach
mt312_attach
mt352_attach
mxl111sf_demod_attach
mxl111sf_tuner_attach
mxl5005s_attach
mxl5007t_attach
mxl5xx_attach
nxt200x_attach
nxt6000_attach
or51132_attach
or51211_attach
qt1010_attach
r820t_attach
s5h1409_attach
s5h1411_attach
s5h1420_attach
s5h1432_attach
s921_attach
si21xx_attach
simple_tuner_attach
sp8870_attach
sp887x_attach
stb0899_attach
stb6000_attach
stb6100_attach
stv0288_attach
stv0297_attach
stv0299_attach
stv0367cab_attach
stv0367ddb_attach
stv0367ter_attach
stv0900_attach
stv090x_attach
stv0910_attach
stv6110_attach
stv6110x_attach
stv6111_attach
tda10021_attach
tda10023_attach
tda10045_attach
tda10046_attach
tda10048_attach
tda10086_attach
tda18218_attach
tda18271_attach
tda18271c2dd_attach
tda665x_attach
tda8083_attach
tda8261_attach
tda826x_attach
tda827x_attach
tda829x_attach
tda9887_attach
tea5761_attach
tea5767_attach
ts2020_attach
tua6100_attach
ves1820_attach
ves1x93_attach
xc2028_attach
xc4000_attach
xc5000_attach
zl10036_attach
zl10039_attach
zl10353_attach

--ei/y4dglsX7VnWMK--
