Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F587A1C86
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjIOKl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjIOKlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:41:52 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF947FB;
        Fri, 15 Sep 2023 03:41:47 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a9b41ffe12so1229216b6e.3;
        Fri, 15 Sep 2023 03:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694774507; x=1695379307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gzWd4qQtjOfUKs0FGdp1XK/HuGB/Tuv7F6Nb03IR5k=;
        b=Od4XrG9KVAUtC6R9pFff67VSepNEnJ8SDuUZk1Vm6r6EVDzBh+Xrg2W3soXlS8XxfI
         +so/Yc3SkApX1gStxfqg0a/lD/CK6j6rWmq10LP1oDcqqZSkvlaLRs2zwp077OtzPXyI
         UkNSmomhWbmBhthgdnejLstIoA/ZmNFk+T6qan301wvHMVnKF/quvv5XbYpJnIq856R7
         MmmDBDgeY9Osi2cWxfZZIAP7Te7Q15j+Q/+S8MojWlgwElobMvmRHqGKHVuA/tjzl+lz
         543uHZeoeq/gK0ljNTqGq2DaB5gkgmrRqTAsbxUz3yW02Cg8FBZT9q2NubIAIcJMB+c9
         Nv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774507; x=1695379307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gzWd4qQtjOfUKs0FGdp1XK/HuGB/Tuv7F6Nb03IR5k=;
        b=R09AQbG6BZAC6Ay6KdImw40q7NhSc6AJ4q+iCg866oX5QQNIe6Iq+qFkOVb7t8/ndT
         qM0w5ebDOFE8mH3wKxHRB5FlRmsEs5fdqleamCiGPQOwTEizj8HstBiPo1MYjQOC0E1/
         C6WWVeulYJ1ze8DldfSF6r/leSZ2dNFWq8TmDGY1YD7zYmFHSCqObxLc+Sgosz2hkPAy
         0RJtSswB+tbdGe8tbutVg37VO4c8Renn9zU67SVFeFxZ4VS/J3rC7JPOBNOawwMYobYz
         D8QX0/2wA2QTIzGpLv4hC7hEexVz4/klu2FxVgGvpULtrLSG97DojUFOtPD42xKfhnNk
         HJzQ==
X-Gm-Message-State: AOJu0YzEX4aldzE06djUKA+NT7LAkDTnF2Bulhk3DARu523HdUyyJKkj
        HS9R1LqucpzLbCVHV9a7Fio=
X-Google-Smtp-Source: AGHT+IFpe8AfKuunKz52MX2dRnnLDy5CuQB9pEFA4YsZtIk2oHpgiy3Q5oOFA1QV6fA7kOMFhhXn4w==
X-Received: by 2002:a05:6808:3bc:b0:3a9:3079:9547 with SMTP id n28-20020a05680803bc00b003a930799547mr1223527oie.30.1694774506732;
        Fri, 15 Sep 2023 03:41:46 -0700 (PDT)
Received: from gondor.apana.org.au ([2404:c804:1b2a:5507:c00a:8aff:fe00:b003])
        by smtp.gmail.com with ESMTPSA id e5-20020a62ee05000000b006889664aa6csm2734052pfi.5.2023.09.15.03.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 03:41:46 -0700 (PDT)
Sender: Herbert Xu <herbertx@gmail.com>
Date:   Fri, 15 Sep 2023 18:41:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Danny Tsen <dtsen@linux.ibm.com>
Cc:     linux-crypto@vger.kernel.org, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com
Subject: Re: [PATCH v2] crypto: vmx: Improved AES/XTS performance of 6-way
 unrolling for ppc.
Message-ID: <ZQQ06U7LEgoZMSY6@gondor.apana.org.au>
References: <20230830134911.179765-1-dtsen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830134911.179765-1-dtsen@linux.ibm.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 09:49:11AM -0400, Danny Tsen wrote:
> Improve AES/XTS performance of 6-way unrolling for PowerPC up
> to 17% with tcrypt.  This is done by using one instruction,
> vpermxor, to replace xor and vsldoi.
> 
> The same changes were applied to OpenSSL code and a pull request was
> submitted.
> 
> This patch has been tested with the kernel crypto module tcrypt.ko and
> has passed the selftest.  The patch is also tested with
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS enabled.
> 
> Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
> ---
>  drivers/crypto/vmx/aesp8-ppc.pl | 141 +++++++++++++++++++++-----------
>  1 file changed, 92 insertions(+), 49 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
