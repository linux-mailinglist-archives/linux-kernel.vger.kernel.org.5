Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9240177BC28
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjHNOzB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Aug 2023 10:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjHNOyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:54:53 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A7E183;
        Mon, 14 Aug 2023 07:54:51 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-40fed08b990so32058731cf.2;
        Mon, 14 Aug 2023 07:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692024890; x=1692629690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65llYxanKLx52DJWCbr7ztUbeAJjX8X82KgD1o/zWXc=;
        b=Oz97Yhbkyu4AUkOezQMzeQMM4MU4TFJCKtoJC1YGA3NQ+BWJjzsZ4PGLYg5WEAM/Km
         O4CSBmB0SGRMOpmWq6yRkfEBhj2/+xl0rVM/SgSmWvRgjPtCcNFvlRMIHkAuD+XGwkE7
         htDjy8H9MIxBbZsmfqFbfE43QSAI2VFv8dxTx+3kLae0fVx145DGvwEoo6YMa/QDoTyo
         n8j0T0A+Y1TZnJ+WraiyMwOC8XqOYvrjSQXSscg5rj4oUqPMsRREsCAtnvVr3oBWo7bP
         wGJtxNbwpPm6AlHqjjDIt+jEVrM3gJeOr82AV21IUo9XjzQP/rRcJpMxM2A7M+aHab7O
         NFlQ==
X-Gm-Message-State: AOJu0YyjI3HV5D5ZAYEzYQdY+t5/UqfFQZZH9gTo4NQtf1ZH+iuNAZ09
        9On0f2IFbvHbWotexPYFfASPo4eFX5gbqA==
X-Google-Smtp-Source: AGHT+IGzGT73FUmoVB8RwsS7+I4SJLglBNLR1LquEyALc1uTs+A8DH4q++f6Nra6cz8beTPaMqu+9w==
X-Received: by 2002:a05:622a:5c9:b0:405:5aed:300a with SMTP id d9-20020a05622a05c900b004055aed300amr14264686qtb.19.1692024890354;
        Mon, 14 Aug 2023 07:54:50 -0700 (PDT)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id z23-20020ac87cb7000000b004054db6da1bsm3161451qtv.53.2023.08.14.07.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 07:54:50 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7679ea01e16so355968785a.2;
        Mon, 14 Aug 2023 07:54:50 -0700 (PDT)
X-Received: by 2002:a25:ac89:0:b0:d5d:4bae:6fe0 with SMTP id
 x9-20020a25ac89000000b00d5d4bae6fe0mr10892642ybi.21.1692024459221; Mon, 14
 Aug 2023 07:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230810091510.13006-1-jirislaby@kernel.org> <20230810091510.13006-28-jirislaby@kernel.org>
In-Reply-To: <20230810091510.13006-28-jirislaby@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Aug 2023 16:47:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXTw-MqmRur+k49ke_ER5sa==He4G0RFqZPSMVfUTXWvw@mail.gmail.com>
Message-ID: <CAMuHMdXTw-MqmRur+k49ke_ER5sa==He4G0RFqZPSMVfUTXWvw@mail.gmail.com>
Subject: Re: [PATCH 27/36] tty: propagate u8 data to tty_operations::write()
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Karsten Keil <isdn@linux-pingi.de>,
        Scott Branden <scott.branden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        David Lin <dtwlin@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Oliver Neukum <oneukum@suse.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:16 AM Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
> Data are now typed as u8. Propagate this change to
> tty_operations::write().
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

>  arch/m68k/emu/nfcon.c                  | 3 +--
>  drivers/tty/amiserial.c                | 2 +-

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
