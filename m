Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921F77B78B9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241524AbjJDH3j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 03:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241513AbjJDH3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:29:38 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E3C98;
        Wed,  4 Oct 2023 00:29:30 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3947SmKhA3077984, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3947SmKhA3077984
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Oct 2023 15:28:48 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 4 Oct 2023 15:28:47 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 4 Oct 2023 15:28:45 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3]) by
 RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3%2]) with mapi id
 15.01.2375.007; Wed, 4 Oct 2023 15:28:45 +0800
From:   Max Chou <max.chou@realtek.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Hilda Wu <hildawu@realtek.com>,
        "alex_lu@realsil.com.cn" <alex_lu@realsil.com.cn>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "Johan Hedberg" <johan.hedberg@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Regression: devcoredump patch broke Realtek usb bluetooth adapter
Thread-Topic: Regression: devcoredump patch broke Realtek usb bluetooth
 adapter
Thread-Index: AQHZ9iZZqIk9cnxrEkOIPrwHFnXgfLA4N/0AgAA1ZDCAABycgIAAkrXQgAAclfA=
Date:   Wed, 4 Oct 2023 07:28:45 +0000
Message-ID: <7507ad6c8a964b179bf2b3318104a124@realtek.com>
References: <20231003182038.k57nirtt4sonvt7c@box.shutemov.name>
 <ZRyqIn0_qqEFBPdy@debian.me> <b2ef2f1c457a4cf7a246b2e8b8598a30@realtek.com>
 <20231004044947.vgegwvxxindkjo7g@box.shutemov.name> 
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.132.197]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! Kirill,
I guess the root cause is as below.
===
static int btrtl_register_devcoredump_support(struct hci_dev *hdev)
{
        int err;

        err = hci_devcd_register(hdev, btrtl_coredump, btrtl_dmp_hdr, NULL);

        return err;
}
===
If CONFIG_DEV_COREDUMP is not enabled, it would return -EOPNOTSUPP for hci_devcd_register().
Unfortunately, btrtl_register_devcoredump_support() will return it. 
Finally, -EOPNOSTUPP will be returned for btrtl_setup_realtek().

Could you have the following workaround for the root cause checked?
Please share dmesg as well. Thanks,
===
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -967,8 +967,9 @@ static int btrtl_register_devcoredump_support(struct hci_dev *hdev)
        int err;

        err = hci_devcd_register(hdev, btrtl_coredump, btrtl_dmp_hdr, NULL);
+       rtl_dev_info(hdev, "%s(): err = %d", __func__, err);

-       return err;
+       return 0;
 }

 void btrtl_set_driver_name(struct hci_dev *hdev, const char *driver_name)
===

BRs,
Max


> -----Original Message-----
> From: Max Chou
> Sent: Wednesday, October 4, 2023 1:45 PM
> To: 'Kirill A. Shutemov' <kirill@shutemov.name>
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>; Hilda Wu
> <hildawu@realtek.com>; alex_lu@realsil.com.cn; Luiz Augusto von Dentz
> <luiz.von.dentz@intel.com>; Marcel Holtmann <marcel@holtmann.org>;
> Johan Hedberg <johan.hedberg@gmail.com>; Juerg Haefliger
> <juerg.haefliger@canonical.com>; Linux Bluetooth
> <linux-bluetooth@vger.kernel.org>; Thorsten Leemhuis <linux@leemhuis.info>;
> Linux Regressions <regressions@lists.linux.dev>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>
> Subject: RE: Regression: devcoredump patch broke Realtek usb bluetooth
> adapter
> 
> Hi! Kirill,
> As your mentions, there's not obvious wrong from the dmesg.
> Could you capture btmon log with raw data? (btmon -w xxx.log) In additional,
> did you build the last version of bluetooth-next?
> By my understanding, you can just duplicate the issue by the commit
> "044014ce85a1 Bluetooth: btrtl: Add Realtek devcoredump support"?
> Unfortunately, I can not duplicate this issue sofar.
> 
> 
> BRs,
> Max
> 
> 
> > -----Original Message-----
> > From: Kirill A. Shutemov <kirill@shutemov.name>
> > Sent: Wednesday, October 4, 2023 12:50 PM
> > To: Max Chou <max.chou@realtek.com>
> > Cc: Bagas Sanjaya <bagasdotme@gmail.com>; Hilda Wu
> > <hildawu@realtek.com>; alex_lu@realsil.com.cn; Luiz Augusto von Dentz
> > <luiz.von.dentz@intel.com>; Marcel Holtmann <marcel@holtmann.org>;
> > Johan Hedberg <johan.hedberg@gmail.com>; Juerg Haefliger
> > <juerg.haefliger@canonical.com>; Linux Bluetooth
> > <linux-bluetooth@vger.kernel.org>; Thorsten Leemhuis
> > <linux@leemhuis.info>; Linux Regressions
> > <regressions@lists.linux.dev>; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>
> > Subject: Re: Regression: devcoredump patch broke Realtek usb bluetooth
> > adapter
> >
> >
> > External mail.
> >
> >
> >
> > On Wed, Oct 04, 2023 at 03:07:24AM +0000, Max Chou wrote:
> > > Hi! Kirill,
> > > I based on Kernel v6.5.5 and updated drivers/bluetooth to the last
> > > version of
> > bluetooth-next tree for a test with RTL8761BUV.
> > > The dmesg log and "hciconfig -a" are correct.
> > > Could you share the dmesg for your failure case?
> > >
> > > [56133.563293] usb 3-1: new full-speed USB device number 28 using
> > > xhci_hcd [56133.712559] usb 3-1: New USB device found,
> > > idVendor=0bda, idProduct=8771, bcdDevice= 2.00 [56133.712577] usb
> > > 3-1: New USB device
> > > strings: Mfr=1, Product=2, SerialNumber=3 [56133.712582] usb 3-1:
> > > Product: Bluetooth Radio [56133.712585] usb 3-1: Manufacturer:
> > > Realtek [56133.712588] usb 3-1: SerialNumber: 00E04C239987
> > > [56133.737812]
> > > usbcore: registered new interface driver btusb [56133.742126]
> > > Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000b lmp_ver=0a
> > > lmp_subver=8761 [56133.743115] Bluetooth: hci0: RTL: rom_version
> > > status=0 version=1 [56133.743124] Bluetooth: hci0: RTL: loading
> > > rtl_bt/rtl8761bu_fw.bin [56133.743754] Bluetooth: hci0: RTL: loading
> > > rtl_bt/rtl8761bu_config.bin [56133.743829] Bluetooth: hci0: RTL:
> > > cfg_sz 6, total sz 30210 [56133.913311] Bluetooth: hci0: RTL: fw
> > > version 0xdfc6d922 [56133.980299] Bluetooth: MGMT ver 1.22
> > >
> > > hci0:   Type: Primary  Bus: USB
> > >         BD Address: 98:A2:35:85:56:F1  ACL MTU: 1021:6  SCO MTU:
> > 255:12
> > >         UP RUNNING
> > >         RX bytes:1670 acl:0 sco:0 events:184 errors:0
> > >         TX bytes:33917 acl:0 sco:0 commands:184 errors:0
> > >         Features: 0xff 0xff 0xff 0xfe 0xdb 0xfd 0x7b 0x87
> > >         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> > >         Link policy: RSWITCH HOLD SNIFF PARK
> > >         Link mode: PERIPHERAL ACCEPT
> > >         Name: 'max-ThinkPad-X230'
> > >         Class: 0x6c010c
> > >         Service Classes: Rendering, Capturing, Audio, Telephony
> > >         Device Class: Computer, Laptop
> > >         HCI Version: 5.1 (0xa)  Revision: 0xdfc6
> > >         LMP Version: 5.1 (0xa)  Subversion: 0xd922
> > >         Manufacturer: Realtek Semiconductor Corporation (93)
> >
> > I don't see anything obviously wrong in dmesg. Attached hciconfig and
> > dmesg for both functional and broken cases.
> >
> > --
> >   Kiryl Shutsemau / Kirill A. Shutemov
