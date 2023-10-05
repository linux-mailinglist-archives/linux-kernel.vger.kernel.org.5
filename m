Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C747BA6CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbjJEQlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjJEQkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:40:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7997E4201;
        Thu,  5 Oct 2023 09:34:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c1c66876aso229592366b.2;
        Thu, 05 Oct 2023 09:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696523665; x=1697128465; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TVELeAMbqDGQTgb0H+LdBlcaOEIyA8bnbU3CE39csMo=;
        b=hGMInpkH4KxvKoa7iTpyK7JnvV16t0CDDH7aqJuatJ5cLWrj20DXUnabz7W6JI63Jl
         eIdwJ+tF+IJ2G5EMHK3eCVoE5ra+4wzxdmvSogf1Tocwd8WlFPG6ScIeHe7KpQ4skOi7
         ZGSxaahuHOxpdgqzbUWlwnOdtn3T+Z7+ijdQYA6ZdakHSr+Iw3/GZ0EiNTlnXRzKjq5s
         gCmXNqQK7/hBonvTOfvRqqKrKTFL48/a7r8G00T1MvkiBsbIBsiySxSMwd+W6UVNAyaF
         wvjhH5LlaZ5qUcFu2lwXgzjg8GxG+gONvGnii1fJ2aZ0T7SO1ufe9rGywKx02k5RocZ6
         fEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696523665; x=1697128465;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVELeAMbqDGQTgb0H+LdBlcaOEIyA8bnbU3CE39csMo=;
        b=ZGQQqxalqSeXPtzitibNKxxBomXTrXjjTgVQjNiWglOGQrK8B5nV+dqKg3Ck3iHS+I
         XzRroHQmUzdSDP7j0jwTtgt+83OLVTBR97qPA7dgXNMbSIelIi/lXIy3PYgBEqg8xa7s
         RKqgVjw426RuF4pKn5bAP1vBGR+ZX/yJ7SFQJK+hQl8ZLV4o5z8aN+wKh9Hx8DkcZEva
         mscrdq7pimOIy7ElpM4zIikV2IbLmcpjbZ0P84+DwbMr0u3JUF7OhHc7h9Iup3orqHwh
         GyC7KwOVOxzlbUZY8mnpdd9q9q0fV66Zocn37MF3u9gMNPqTV0uXky69liZuYosrD7gx
         RJSw==
X-Gm-Message-State: AOJu0YyZIXRiSaxDpfplhXzXys0P2ubtynSkOBWbSpneeBBV82i4A1dQ
        IotRGVa47IbUKv6kaB67hA==
X-Google-Smtp-Source: AGHT+IFB36AeEXaPu0q6jpcdY7fJZGSxOblkQscd1nl+87XkgvPLXWtiribZ/loKyzYb/jWR7oLAbQ==
X-Received: by 2002:a17:907:2704:b0:9ae:5492:64e with SMTP id w4-20020a170907270400b009ae5492064emr4686541ejk.25.1696523664571;
        Thu, 05 Oct 2023 09:34:24 -0700 (PDT)
Received: from p183 ([46.53.253.206])
        by smtp.gmail.com with ESMTPSA id m14-20020a1709066d0e00b00991d54db2acsm1428974ejr.44.2023.10.05.09.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 09:34:23 -0700 (PDT)
Date:   Thu, 5 Oct 2023 19:34:21 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: stack leak via uart_get_info() ?
Message-ID: <967b9ef1-fb36-48bf-9e6a-1b99af24c052@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If this check ever triggers

	static int uart_get_info(struct tty_port *port, struct serial_struct *retinfo)
	{

		uport = uart_port_check(state);
	        if (!uport)
	                goto out;

then all those sysfs users will print stack contents to userspace.

Can it trigger while sysfs read is executing?


Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -775,6 +775,8 @@ static int uart_get_info(struct tty_port *port, struct serial_struct *retinfo)
 	struct uart_port *uport;
 	int ret = -ENODEV;
 
+	*retinfo = (struct serial_struct){};
+
 	/*
 	 * Ensure the state we copy is consistent and no hardware changes
 	 * occur as we go
