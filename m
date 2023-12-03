Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC7A80264A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 19:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjLCSfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 13:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCSfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 13:35:14 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CCDDA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 10:35:19 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d04d286bc0so11437895ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 10:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701628518; x=1702233318; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XofiGJnHsU0gR6jHZzAR0X0zZqTCu60EVqYYZjegzVc=;
        b=mXRxeQOZHbsK2lz4PsG09Ie4PuMcemFF81Iq319KptVmkq+Ra7SU/W54Rrys1rmW45
         ADjlZWOHbMKCvMdhSUYj+xjoYhyQd0GInDtpcf8puacQ9QfYo2hxqN38uX+uIZ0TmLo1
         Sub/AjOaVbZ+a3z+AHNDk3i4stMVV26wl5+wWLF2tVfor0XtD9dKIvH6ZVxAdGflwXkC
         +7/Bl11zFb7E1C8Jli5Hg/P8zGYZjS6PB78Z+iToNjlr71N9cpPLrI+oah0cLGQafrz/
         jT7WUijvE0lFh/u1wv7C02lVP+sUuIyR8iCgv7u4YR2zgh8bCQPmuJd+IAdrPZvGgSAh
         e4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701628518; x=1702233318;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XofiGJnHsU0gR6jHZzAR0X0zZqTCu60EVqYYZjegzVc=;
        b=GAEQmff9BX1XlBJnqPiFFjqddJFUTdFWfLKHLSNR6bm9kBXKZ4VA8dZ9QLKvD/3be9
         m9G0vCrEEjGaLDC7ENpE/Ia+CGC+Bw51bSoikw/iEKNkUZnTP3YkMHjmrBOr3HcmChOO
         PLuChjnHbPYAxgOJhPnQUtag37Z2H/PkOhjcU3jry+ByMiLXsDMuL4NMQ6UDd5MPnVQy
         ILVl7+UlcGDcTNmJMSotkSWQ0KS//2xwIn+slTb424f13M0IvMTD8LifuEJZ9VXZEcGv
         rKKKGG/qbjzLnJ+3BZ1onN7PYWLFHz3p6B+iq+b8mKTNYZo99NwkIKWwcO6o9T8de5Ja
         x/EA==
X-Gm-Message-State: AOJu0YxsQJSOeJJSolbPwKw7hiGWTbdv0Q4Ah+f2RBEa2c+XETRdzMk0
        tj//8Q0cQSoPGvthdLqCEeEgSpoFYtw=
X-Google-Smtp-Source: AGHT+IFcNTCqvliU8fIDZ1fl1Z6Yf/A/136fsYOotxzDpoq9vEcM3vxIB3DL+nn4B5WGbeGOTr5q8Q==
X-Received: by 2002:a17:903:2285:b0:1d0:71db:d427 with SMTP id b5-20020a170903228500b001d071dbd427mr761317plh.134.1701628518472;
        Sun, 03 Dec 2023 10:35:18 -0800 (PST)
Received: from google.com ([205.220.129.26])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902f69300b001cfa91a0570sm6935117plg.155.2023.12.03.10.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 10:35:18 -0800 (PST)
Date:   Sun, 3 Dec 2023 18:35:00 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?iso-8859-1?B?Wm9sdOFuIEL2c3r2cm3pbnlp?= <zboszor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        zboszormenyi@sicom.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] egalax_ts_serial: Fix potential buffer overflow
Message-ID: <ZWzHv7X1UKgJJYTy@google.com>
References: <202312021646.cwwvptuB-lkp@intel.com>
 <20231203090600.85890-1-zboszor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231203090600.85890-1-zboszor@gmail.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zoltán,

On Sun, Dec 03, 2023 at 10:06:00AM +0100, Zoltán Böszörményi wrote:
> @@ -42,7 +42,7 @@ struct egalax {
>  	struct serio *serio;
>  	int idx;
>  	u8 data[EGALAX_FORMAT_MAX_LENGTH];
> -	char phys[32];
> +	char phys[NAME_MAX];

This simply wastes 200+ bytes for no good reason. It is perfectly fine
to truncate phys string (which does not happen in practice).

If you feel strongly about it then maybe use devm_kasprintf() to
allocate the needed buffer.

Thanks.

-- 
Dmitry
