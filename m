Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4697F2404
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjKUCck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjKUCci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:32:38 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6E6AA;
        Mon, 20 Nov 2023 18:32:34 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-280260db156so4075990a91.2;
        Mon, 20 Nov 2023 18:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700533954; x=1701138754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQew7RH4p+btfi+SdVSn7rImpVweNTfJ1E+cxn9Oa3Y=;
        b=lES7krgrQmoiYh0gjXBcikFtuM1lymu0SwgDUgbWn4Af9Wd2W+/BgmxMWmDZX/D+k5
         yCnI/DjBLpKqhaPU74RaRsn+otKYeY8prCuRKVuLF6f/baIHmXUWDhMXlyl4TWl5i+kN
         P9yUMmjCV833qP0CAOEWzotwQv9bLCH+oQ/tpYky5/2Ps4wUG7WiFnmrI1kt2dkK41Mf
         RcDQm1CO0urDjaiI9vZrykL2+lZbE44Vl3GDhULhSbGyL1bbSyyVqUKOR2UdhDT7O4Vb
         M1evvDiQFyJHcoOM80WnuS4Svk54qRJUR8PtZm6mG/rZGJQaozMUGDTzO3zCR2btYva6
         Q8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700533954; x=1701138754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQew7RH4p+btfi+SdVSn7rImpVweNTfJ1E+cxn9Oa3Y=;
        b=AbzojQzHYOwU5S2AqgEVqpAqVG4txTV0hzwsjdHsw1ltES2zuwInMzaSNzfKPcJhY8
         4KGXoGvb2R9L0TnkCI2QzhzbevMA3beEj2wHthxjdnAbsoeHSsiEgVHwl0mCUIyrIBVz
         S/OcDucTNneV5L41bT5+TSlyYb36/XCIB0F0CLU5ZNykNdRtqJrkYn2dodJ8KmsSeVDM
         YUqpZEKr6Ho8QC0rOFZA0K6IYhi7nVR5IihmRKLcOiKPTlFgucpn4lDPcBh1eaS/r6HG
         m08MtVZUjHMKYCGXOt6KoCAF7lTWj5I2Hdw9V9GduETRW+qFlGbfrrgxoWgcIjW1Cqru
         zx5g==
X-Gm-Message-State: AOJu0Yzqdg9mfnLu1ZSP1DBLa9hr6f7vRvcM37bI7qihkDJKjJl+n3gE
        kAWZnbVs5EJk2qb1Sq9E4ys=
X-Google-Smtp-Source: AGHT+IHvSLti2T6hWxeoUwCXb1/iZfeSz/1D8OBBI1w37OB2l4IhqbGBaS4QwJYYnUZeIEZigkt4mw==
X-Received: by 2002:a17:90a:fd17:b0:27c:f8f4:fedb with SMTP id cv23-20020a17090afd1700b0027cf8f4fedbmr10446951pjb.21.1700533953085;
        Mon, 20 Nov 2023 18:32:33 -0800 (PST)
Received: from localhost.localdomain ([154.85.51.139])
        by smtp.gmail.com with ESMTPSA id cz8-20020a17090ad44800b00280fcbbe774sm6272758pjb.10.2023.11.20.18.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:32:32 -0800 (PST)
From:   Yusong Gao <a869920004@gmail.com>
To:     a869920004@gmail.com
Cc:     davem@davemloft.net, dhowells@redhat.com,
        dimitri.ledkov@canonical.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, jarkko@kernel.org,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, lists@sapience.com,
        zohar@linux.ibm.com, juergh@proton.me
Subject: [RESEND PATCH v2] sign-file: Fix incorrect return values check
Date:   Tue, 21 Nov 2023 02:32:19 +0000
Message-Id: <20231121023219.846984-1-a869920004@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120013359.814059-1-a869920004@gmail.com>
References: <20231120013359.814059-1-a869920004@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 7:44 AM Jarkko Sakkinen <jarkko@kernel.org>
wrote:
>
> On Mon Nov 20, 2023 at 3:33 AM EET, Yusong Gao wrote:
> > There are some wrong return values check in sign-file when call
> > OpenSSL
> > API. For example the CMS_final() return 1 for success or 0 for
> > failure.
>
> Why not make it a closed sentence and list the functions that need to
> be
> changed?
>
> > The ERR() check cond is wrong because of the program only check the
> > return value is < 0 instead of <= 0.
> >
>
> Lacking Fixes tag(s). See:
> ttps://www.kernel.org/doc/html/latest/process/submitting-patches.html
>
> > Link:
> > https://www.openssl.org/docs/manmaster/man3/CMS_final.html
> > https://www.openssl.org/docs/manmaster/man3/i2d_CMS_bio_stream.html
> > https://www.openssl.org/docs/manmaster/man3/i2d_PKCS7_bio.html
> > https://www.openssl.org/docs/manmaster/man3/BIO_free.html
>
> Replace with
>
> Link: https://www.openssl.org/docs/manmaster/man3/
>
> BR, Jarkko

Thanks a lot for you comments, I will fix that.

BR, Yusong Gao
