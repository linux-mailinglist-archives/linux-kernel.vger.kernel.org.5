Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B46280AE8F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574758AbjLHVFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjLHVFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:05:07 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E01171E;
        Fri,  8 Dec 2023 13:05:13 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35d6644c1f2so6556365ab.0;
        Fri, 08 Dec 2023 13:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702069513; x=1702674313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YaHiAFt40ikMOsz0Nbfpr3rQu22G+/tz5j95vM1fm2s=;
        b=hvb2CS2QIgueTVH/drFMVoPB61jOR20LDQJ/4PSCuF0+e2U9T5DR5CXc8BwPwdnjnY
         3M5JrYRGWUhWp/bueVcpd5Ybes7mXlykQUhM7mUHwtWzz0lHEa5pSKihbB9IPoSODWCX
         4C+P9t4tyVUKf78akTF7Zs45pWzNZYNEKMhCClulbzfulqoXAZmqh8PFQgRQvC5pLhTn
         ZSt0Lx/8u+OsOBTkAgyZVLIVd5F8uNjdZC72vRh2rraLUT8SQLuICji6Di6sMluOLOPV
         PLGBbPEEamOKOyRObL41nRDW9dJIHnsNBRWaCghHR6wsbUcWHenSjwiOX7AOZIkZeLtj
         am0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069513; x=1702674313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YaHiAFt40ikMOsz0Nbfpr3rQu22G+/tz5j95vM1fm2s=;
        b=pWgqtLgHHcsu8AdlQZuVtsDk75tpgJbGZ7vKUrFnrwIURk/dw2pIQu+5V0L9eKLKBQ
         yC/3W6CBZb5Msyw2kwzx2evZxvcyPQk8Xk9EB0JzyMKNsNtPqQiJLqk7p9dQYKx7pdLZ
         ujbLK6PC5GzJeF+S6qEWatE1o63JQeeQ2XVSkuTWWJrEJHHlLUH5Ppj4HvkNbmoqrHDh
         n/d9sn72ZOGn12pTzJL4IzRBJ+1ovnojSqcHBCgblPaiZlwFK1/IqSfI1Blp9vSRX24c
         NXclShXIzL/s632k8rr2q4Pm0lQHInBP/eOF72Kw/jLbmFrJdnmzUEVCLX9sHdOewlxY
         /q4Q==
X-Gm-Message-State: AOJu0Yxqm3V+Tyc8KbyAACnTR2r2bAsm8qFHb95EFjjvYhQFlo51lZsu
        GmhlODeWdktdZCyxKwbtn40=
X-Google-Smtp-Source: AGHT+IG8kw2miyA1RJmJqkYCjJ+/skxqXiSep0R5Ldu23xLkq4yF4irBjYP+jGVdgfT12EynmKDxfw==
X-Received: by 2002:a05:6e02:2148:b0:35c:a889:76f2 with SMTP id d8-20020a056e02214800b0035ca88976f2mr588804ilv.8.1702069513024;
        Fri, 08 Dec 2023 13:05:13 -0800 (PST)
Received: from celestia.nettie.lan ([2001:470:42c4:101:971d:15c7:de39:3b4b])
        by smtp.gmail.com with ESMTPSA id g12-20020a056e020d0c00b0035d5a1760c1sm736458ilj.69.2023.12.08.13.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:05:12 -0800 (PST)
From:   Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 0/2] Allow disabling USB3 ports in xHCI/DWC3
Date:   Fri,  8 Dec 2023 14:04:56 -0700
Message-ID: <20231208210458.912776-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi USB devs,

This patchset is a semi-RFC: I haven't discussed this change yet, and it may
turn out to be a bad idea. But if there is a consensus that this change is
appropriate, these patches are the ones I'd submit for inclusion.

These patches were developed while working with a SoC (Rockchip RK3588) that
contains DWC3-OTG controllers and accompanying USB2 + USB3/DP PHYs. My target
(Turing RK1) uses its first bus in USB2.0-OTG mode only: the associated USB3
PHY is reserved for DP. Worse, a driver for the USBDP block (though it exists)
has not been merged to mainline. Without lighting up the PHY side of the PIPE,
the DWC3 behaves erratically, even for USB2 operation.

This could be addressed by patching in the (out-of-tree) USBDP driver and
enabling only its USB backend. However, I found it cleaner (also from a
user-friendliness standpoint) just to disable the unusable USB3 port. These
patches achieve that by (1) making it possible to tell the xHCI driver to
ignore any USB3 port(s), and (2) (perhaps more controversially) making the DWC3
driver disable USB3 host ports when `maximum-speed` isn't set high enough.

There are other ways to disable the USB3 ports on RK3588, such as via some
syscon registers. I figured I would start with the most general solution
(benefitting other SoCs) first, getting more specific only if necessary. :)

Thank you for your attention,
Sam

Sam Edwards (2):
  xhci: Introduce "disable-usb3" DT property/quirk
  usb: dwc3: host: Disable USB3 ports if maximum-speed doesn't permit
    USB3

 Documentation/devicetree/bindings/usb/usb-xhci.yaml | 4 ++++
 drivers/usb/dwc3/host.c                             | 5 ++++-
 drivers/usb/host/xhci-mem.c                         | 4 ++++
 drivers/usb/host/xhci-plat.c                        | 3 +++
 drivers/usb/host/xhci.h                             | 1 +
 5 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.41.0

