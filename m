Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F57773DCD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjHHQXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjHHQVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:21:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC06D9EC8;
        Tue,  8 Aug 2023 08:49:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bf1f632b8so875156966b.1;
        Tue, 08 Aug 2023 08:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691509750; x=1692114550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O3JDBlhThehmzGpl6qM9UdpbRL+nxpaOBfK296WrIFw=;
        b=cualjSg//7wD7yhW5nRXtrI8hUcY9YK46FTT9oPp2JCiivyr/2sMZpZ4pGazpui7e/
         zB8CnpAd91BOsxjUpsp+LeI7TuZsOuie6b/xeZna/U3nDhxYUfAwH7Nxxq3yyPGQqbdH
         hfNdrwuS9rqz+r5Z/NOw8OwjfZ6VOYUXvgWfxfFo/G3rs2EJ2hP8Q3aBOIj8K6cqUYvb
         oaLAvnVNx5u6uUzI59FaIjIM/6WQqIf1b+bkZCQtcPoOJpioRH14NekX/VSeLxGN5lfU
         rJ9PLEPyK8Lhm+fLdU4gT5FyZPDwsECB6vlC2zrJfiJT8NQeXLtBRswZ4csm5HO4fLCD
         7Zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509750; x=1692114550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3JDBlhThehmzGpl6qM9UdpbRL+nxpaOBfK296WrIFw=;
        b=fMBK090GZDxW2SIctSRpTIRDLLzEsbh0y5LfvDpexsRt10xtjFr6mmhAFQdsnosN5j
         NnTbkQ+rnhh1FrShF9X7nnb1FCaSHZ2Q9Q3fpbyba8cXUeCpEb+33CLRP8FIpV20O49a
         qKYpPlW4bAJ1+0QSviGueGmvhUga1t8QTPNA+1BuDgGoN/5GQCeTK17CUAalpoc/Nfo7
         cXLlg847mYQneLfpHT9/VKHAJfSXy2g0O9+jIHjaL1ka9JsJ43Qk1YMl47ZRkep5U67/
         iw5DAIdu6eujli5pZl3AYhFgRq0KSzdRQXWiOPNa/YRdSPoXIfWVsrDi/BKF9GkLsTsP
         kJhg==
X-Gm-Message-State: AOJu0YxL6dkajTpFkyW4M6vuw/fR/tofhUPJDOtD3Wl9y3W1bciOOLfg
        YtUdCrLGk8OAz6UxM+w+Iw/WXPn8gDQ/UC1hBnT0QnNiwCELxQ==
X-Google-Smtp-Source: AGHT+IEiZQ5mtN03JK3pZU9kp2Es6dYBa8b9ZJY1FIJC222Xvs0ImshT9RkLj/PUowndmS7IcAaCmUcsKbprP1G2qLo=
X-Received: by 2002:adf:f007:0:b0:317:690e:7b39 with SMTP id
 j7-20020adff007000000b00317690e7b39mr8151172wro.12.1691507845886; Tue, 08 Aug
 2023 08:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230729092634.78336-1-dg573847474@gmail.com> <2023080817-antler-enchilada-cccf@gregkh>
In-Reply-To: <2023080817-antler-enchilada-cccf@gregkh>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Tue, 8 Aug 2023 23:17:14 +0800
Message-ID: <CAAo+4rWHSmKe8eh0=2vWGS-pfhR+GXNwZ6uBAqR=ePnBJ-vFog@mail.gmail.com>
Subject: Re: [PATCH v2] usb: host: oxu210hp-hcd: Fix potential deadlock on &oxu->mem_lock
To:     Greg KH <gregkh@linuxfoundation.org>, gustavoars@kernel.org,
        u.kleine-koenig@pengutronix.de, giometti@linux.it
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for pointing out the formatting error in the patch.

Truly only building testing is performed as mentioned in commit but
no hardware testing was able to be performed. The bug was detected
by tool and also reviewed by myself, I thought it could be a real issue
so I send the patch to fix it by using safer irq-variant locking API.

I understand the guideline and appreciate it. Would be grateful if anyone
who has written/is familiar with the driver could review whether this is
a real bug and whether it should be fixed.

Best,
Chengfeng
