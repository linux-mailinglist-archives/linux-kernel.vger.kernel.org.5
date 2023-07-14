Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ECF753107
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjGNFS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjGNFS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:18:56 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADF61BFA;
        Thu, 13 Jul 2023 22:18:54 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b74fa5e7d7so23368011fa.2;
        Thu, 13 Jul 2023 22:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689311933; x=1691903933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qanFZMj30IH4XW48WS0t6ILLRq3RPYhmVjv06bs4ifs=;
        b=ocHt077NOqJgR/r/AnSkTtXME0GBY2YvFrJMUkK/HReb5GKgR0PSEXUAwNrQyvTzrZ
         WhOTnDSvJa43aNxuo0C++s0HxDE7B76u9aFlT/TrrX1hGWa6R9MmseWw0b23iWDkjxS+
         790Mce8LTojIbjb2vRnQIMF7QjDbGYGGRROvXOl1FNWijTcH9HdlNH5GARWvA3M1Rd5v
         VGF34BYfbXZ7AqpAcr9bXdw2FfdGB4jakjeGp7TNDv2GdlsdLNe504osmEJ7dYkNA0rk
         nFD9MIdfYVpls54NEE8KiW9Ny96vziJlPDvtTKUxPCFrhyP6A3kD03o0uoTP8eb/DOIw
         AYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689311933; x=1691903933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qanFZMj30IH4XW48WS0t6ILLRq3RPYhmVjv06bs4ifs=;
        b=g+zOY1DhsyvQ/WBl3adUd1Aw/mRiS5wXtUBOjacZVMx6EbQMETeJzV62LHUu/azGeW
         xESDzlnoZxffPb/memmr9Zrj2rlXAn2IjrNhjy/HDR/r8Qnov5/Irr4W3pMDfrb6kKwx
         RxSSI8P8MueiI3onvVFxloRU1VMVQEAn1zcJjAnr+S6/+dYNmNASq8c62S/ykQP32RxU
         wN6+1OytH8fY5AEHFYw8PdUPayD1zfv5a8gzjDhVbPYeaE6z0wz47hvSoOnUJngXGafR
         cmz1ZbVo6MgS5uW5f0OyEWtcUeemDtX+6tz1MH6nOx0BdEqUiWS1Z/bjMhtbm0zreYXU
         jwWQ==
X-Gm-Message-State: ABy/qLbxlHJdqGEk/cgJetwDflkPdKNJ0o5BCU9T3T1sMQqVknRNmdbK
        4aC+N0SLM+z5pcTK5ltovvE=
X-Google-Smtp-Source: APBJJlGxgthe95pGtfOYdEqnunDYQ9Kdsp6Bokjz5y6f0Rvss1Ai7/1q54Fx0YbtPfESYolrgvu6Jg==
X-Received: by 2002:a2e:9d0f:0:b0:2b6:f21c:2c46 with SMTP id t15-20020a2e9d0f000000b002b6f21c2c46mr2781140lji.53.1689311932414;
        Thu, 13 Jul 2023 22:18:52 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id e16-20020a2e9310000000b002b6cb40e9aasm1762440ljh.103.2023.07.13.22.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 22:18:51 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-22) with ESMTP id 36E5Imqq000481;
        Fri, 14 Jul 2023 08:18:49 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 36E5Ihls000480;
        Fri, 14 Jul 2023 08:18:43 +0300
Date:   Fri, 14 Jul 2023 08:18:43 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Liang He <windhl@126.com>, Geoff Levand <geoff@infradead.org>,
        Leon Romanovsky <leon@kernel.org>,
        Tao Ren <rentao.bupt@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ftgmac100: support getting MAC address from NVMEM
Message-ID: <ZLDas0gsLNkzuUWR@home.paul.comp>
References: <20230713095743.30517-1-fercerpav@gmail.com>
 <CALs4sv08GJXexShzkrhhW5CDSgJC0z3om5YJzy_qYRqEtvyMtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs4sv08GJXexShzkrhhW5CDSgJC0z3om5YJzy_qYRqEtvyMtg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pavan,

On Fri, Jul 14, 2023 at 10:14:02AM +0530, Pavan Chebbi wrote:
> On Thu, Jul 13, 2023 at 3:28 PM Paul Fertser <fercerpav@gmail.com> wrote:
> > Make use of of_get_ethdev_address() to support reading MAC address not
> > only from the usual DT nodes but also from an NVMEM provider (e.g. using
> > a dedicated area in an FRU EEPROM).
> 
> Looks like earlier ftgmac100_probe() would move on with self generated
> (random) MAC addr if getting it from the device failed.
> Now you will fail the probe in a failure case. Is that OK?

I think the previous behaviour is preserved with this patch in all the
cases other than of_get_ethdev_address returning -EPROBE_DEFER. Can
you please explain what failure case you have in mind and how the
probe is going to be failed in that case?

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
