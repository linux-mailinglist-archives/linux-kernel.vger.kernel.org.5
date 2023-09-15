Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DD27A21F1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbjIOPIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbjIOPIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:08:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12B32D74;
        Fri, 15 Sep 2023 08:06:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C54C433CC;
        Fri, 15 Sep 2023 15:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694790408;
        bh=IQ4jNnb8O59E3cdlKNIHXXCnhjQ3SLQvaH2x8wn4EKA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kFDvk+M5XPChCC0bsDB28I+oa6wrT8Irzf80KeRAm/Xl+6opjFbtjN8N6FJd5jrIK
         PK8g5R+xbX9SkaBvmTbeGIpxnqQ4rzWmipFvVKR6GD9esa+SAIcGzMBMv7zL1ADHAX
         ZwUrVOfAaHxTxccBm0VN5X1b5E594AK9CyN9cdfmEtB8R3VCDA9IYvaM6Rl5vFb5IS
         9ts8OwOzsS3S2N08jWIcy/4qS/k9lrxCjukgutbO6Q8b8CNaTjtc/ShIr7vgOcTL5n
         SYnzT4qWze+BMcrptcYE3qepQu4fQaKCwwYqZO/SX9o/xRysxF9wx/f4B+e015/xEv
         E8vNpY/niCj5Q==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9ad8bf9bfabso289481566b.3;
        Fri, 15 Sep 2023 08:06:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YxOp5V+zzBF4zNC3/XKX9myPq446co0gVS/9OTxp/SmoENorOLn
        fTeffIUH+X4hwCR+6I5o0j/0ErTEAyQUCxS+SAM=
X-Google-Smtp-Source: AGHT+IEkpvL8z9mod1wRru0al+0HgtxhmY/i66NFpzanejWLMwonmLjSDsnChchGQ87ISgJ662MIgIUOXG6g3QhoMKc=
X-Received: by 2002:a17:906:105c:b0:9a3:c4f4:12de with SMTP id
 j28-20020a170906105c00b009a3c4f412demr1601827ejj.37.1694790406842; Fri, 15
 Sep 2023 08:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230914183831.587273-1-john.ogness@linutronix.de> <20230914183831.587273-73-john.ogness@linutronix.de>
In-Reply-To: <20230914183831.587273-73-john.ogness@linutronix.de>
From:   Timur Tabi <timur@kernel.org>
Date:   Fri, 15 Sep 2023 10:06:10 -0500
X-Gmail-Original-Message-ID: <CAOZdJXVRXwsq2c5dTbHJCYojU=_Ck6=VOtmyKXPP3TzTQs8MiA@mail.gmail.com>
Message-ID: <CAOZdJXVRXwsq2c5dTbHJCYojU=_Ck6=VOtmyKXPP3TzTQs8MiA@mail.gmail.com>
Subject: Re: [PATCH tty v1 72/74] serial: ucc_uart: Use port lock wrappers
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Timur Tabi <timur@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 1:39=E2=80=AFPM John Ogness <john.ogness@linutronix=
.de> wrote:

> Converted with coccinelle. No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/tty/serial/ucc_uart.c | 4 ++--

Acked-by: Timur Tabi <timur@kernel.org>
