Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147077BEAD4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378459AbjJITsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378397AbjJITsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:48:21 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABD493
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:48:19 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690bd8f89baso3636019b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 12:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696880899; x=1697485699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YnnGBorqi/0sryABcLeiVXw4usVlXXVKQE9toG3inJM=;
        b=e23yKq1wv/lY0x9LjebsVqZvLDC3yPdbjBtEyEgGrIxa5/qW5r8N3OKAZN6Fe4AI2C
         iBYNB18joJFFK+/Of93yr1coecNoCqRoHQOzFzxtTQvgQzAVc+JKy3yXUm0PscC5TDD8
         VyIz40oa3DURNPKhXQnNorxfjCrCgHOEwuaXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696880899; x=1697485699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnnGBorqi/0sryABcLeiVXw4usVlXXVKQE9toG3inJM=;
        b=HhUTe58G3AafCTGVgczPWu1iPsu7T6PwsInfRhARSfLlvvQFrUSYqQkdrNhs/fJ2zf
         OHlofanAkr3s4KmJhcrMeDzR7zzG6TFiVCqwwYYPL4yLLxUuAFZC4hfbQJiV9mhn98tR
         /N6QfQUayfIigfX0ko9epKN1lKAvCMc98O/lEr1fYaGXwJxUI5xawK91BiB3SdwsXSwv
         iYMyz6EMVEhagcoIpzFepEeO35oQrk+9XVnE0CS6LyEzbhDucU8QfACNbQIOz5tjg6dV
         9+/2/i4Tnu76op2gGFC4w802FmLM/VeaK3fbHt81oMBVLa0TqdFxhk/pX45S/g7QX7ly
         xw9A==
X-Gm-Message-State: AOJu0YxsY7XBuhl3FaQbhKn+zegyW7STr3zshbLT2rPRv6CXr96nPCVg
        8suYtbnc3IOaEABcsVe9oXOzZw==
X-Google-Smtp-Source: AGHT+IH/EU8sCax66tncCUgtwE24oZqKUnAw5nHePbac/qTNhw0neUzqI+uVELgQYBYwoASCkEKRUQ==
X-Received: by 2002:a05:6a00:1516:b0:691:da6:47b with SMTP id q22-20020a056a00151600b006910da6047bmr16111870pfu.10.1696880898803;
        Mon, 09 Oct 2023 12:48:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fn27-20020a056a002fdb00b00688435a9915sm6820661pfb.189.2023.10.09.12.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:48:18 -0700 (PDT)
Date:   Mon, 9 Oct 2023 12:48:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Chun-Yi Lee <jlee@suse.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        stable@vger.kernel.org, Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-bluetooth@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: mark bacmp() and bacpy() as __always_inline
Message-ID: <202310091246.ED5A2AFB21@keescook>
References: <20231009134826.1063869-1-arnd@kernel.org>
 <2abaad09-b6e0-4dd5-9796-939f20804865@app.fastmail.com>
 <202310090902.10ED782652@keescook>
 <73f552a4-4ff5-441a-a624-ddc34365742f@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73f552a4-4ff5-441a-a624-ddc34365742f@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 08:23:08PM +0200, Arnd Bergmann wrote:
> On Mon, Oct 9, 2023, at 18:02, Kees Cook wrote:
> > On Mon, Oct 09, 2023 at 05:36:55PM +0200, Arnd Bergmann wrote:
> >> On Mon, Oct 9, 2023, at 15:48, Arnd Bergmann wrote:
> >> 
> >> Sorry, I have to retract this, something went wrong on my
> >> testing and I now see the same problem in some configs regardless
> >> of whether the patch is applied or not.
> >
> > Perhaps turn them into macros instead?
> 
> I just tried that and still see the problem even with the macro,
> so whatever gcc is doing must be a different issue. Maybe it
> has correctly found a codepath that triggers this?
> 
> If you are able to help debug the issue better,
> see these defconfigs for examples:
> 
> https://pastebin.com/raw/pC8Lnrn2
> https://pastebin.com/raw/yb965unC

This seems like a GCC bug. It is complaining about &hdev->bdaddr for
some reason. This silences it:

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6f4409b4c364..509e86b36576 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3266,6 +3266,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 	int mask = hdev->link_mode;
 	struct inquiry_entry *ie;
 	struct hci_conn *conn;
+	bdaddr_t a;
 	__u8 flags = 0;
 
 	bt_dev_dbg(hdev, "bdaddr %pMR type 0x%x", &ev->bdaddr, ev->link_type);
@@ -3273,7 +3274,8 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 	/* Reject incoming connection from device with same BD ADDR against
 	 * CVE-2020-26555
 	 */
-	if (!bacmp(&hdev->bdaddr, &ev->bdaddr)) {
+	a = hdev->bdaddr;
+	if (!bacmp(&a, &ev->bdaddr)) {
 		bt_dev_dbg(hdev, "Reject connection with same BD_ADDR %pMR\n",
 			   &ev->bdaddr);
 		hci_reject_conn(hdev, &ev->bdaddr);

:(

-- 
Kees Cook
