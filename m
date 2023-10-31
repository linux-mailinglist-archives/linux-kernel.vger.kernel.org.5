Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081627DD819
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344928AbjJaWPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344732AbjJaWPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:15:16 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06E2EA;
        Tue, 31 Oct 2023 15:15:13 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c5720a321aso79998251fa.1;
        Tue, 31 Oct 2023 15:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698790512; x=1699395312; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8nZsj+AfOY0spxTisMoArNXhnnKSbd2tnGFeggkpIho=;
        b=OP2eWD0OSYfksJ+um+RrOYnOWGCxbXtLDh6UrZsrSC9dSEYIUDotKPNTkXdwDeepQ9
         qiWzrNBocegp2p8mPD5te8tu9Ohl4IIbC1kTGGqawuOmphr1a7CtmT7MXDVR8A/onQmS
         F9AFlHqvsItxYU9BvAlNrM1XRxwVSU8QTdS1ieWmCjQbrMVhDxiY5/hgufyVNKIlcVNW
         IOc7SKLWuwGpZ7m+7fWaBLrsShN52USanMobZ43tEY6vNjuWuWdj+yM+uFN+fCGRn96s
         fYywSBXyVxfjMCswkVCj6FhPY6PrrTeZnHsdPaTIkG/tQYTZkzWIZXQrT/2BMeokPQN4
         3bOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698790512; x=1699395312;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nZsj+AfOY0spxTisMoArNXhnnKSbd2tnGFeggkpIho=;
        b=wyNsjxSUYYGLjaUlNxRXT1Qm0qTUTS5FPlBOcUmwmpoDame3k3Xh4ispMJfRq8BkX8
         eIXyKXx/fsPI8UU3NRQJhYzIm3EiLKuQHCaF7MZnT7K9xq/EBVOVB47OT8Bno5VStlBE
         ImbJyaFkIrGNEOd69OLKEA0l8WjFQikoZxaDUJwl7GNXbcvGopUHEPeAFih+EsG1Zlj5
         UOhjAO8eeGutqhxMT8MXNbXCOB+pGeM66obroPcPmJ7sWYltQ8iU0vsCiuEY38ck3DPx
         n+NS2QYVaN0xDXE+uE5zZp7BJone3Q0sJgQlo9xT/TVjuhzZDschvIRedmxVcWa92HsQ
         IJbQ==
X-Gm-Message-State: AOJu0Yy4tNdEdResaOCxDmZKfGPIlgqNNCC3BoSHZrYk7XJ5rUXBJXLa
        P02zWhBLPhNW02gT0pTLZNHZwSOiF4o=
X-Google-Smtp-Source: AGHT+IFUJkmKnTlNM3eRoWukUht05K2CCKE+eMRQXaMITsgnFMh2M95EPetfMMsr28J5oLwNJeSDrg==
X-Received: by 2002:a2e:1454:0:b0:2c5:169f:ff03 with SMTP id 20-20020a2e1454000000b002c5169fff03mr9751364lju.5.1698790511467;
        Tue, 31 Oct 2023 15:15:11 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003fc16ee2864sm2930790wmb.48.2023.10.31.15.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 15:15:11 -0700 (PDT)
Date:   Tue, 31 Oct 2023 22:15:09 +0000
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev
Subject: mainline build failure due to 5cfd69775eb5 ("bcachefs: Array bounds
 fixes")
Message-ID: <ZUF8bYTl5SBlbBBJ@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build arm64 allmodconfig
with a native build on an arm64 host with the error:

In file included from fs/bcachefs/btree_io.c:11:
fs/bcachefs/btree_update_interior.h: In function 'want_new_bset':
fs/bcachefs/btree_update_interior.h:274:36: error: array subscript 0 is outside the bounds of an interior zero-length array 'struct bkey_packed[0]' [-Werror=zero-length-bounds]
  274 |   __bch_btree_u64s_remaining(c, b, &bne->keys.start[0]);
      |                                    ^~~~~~~~~~~~~~~~~~~
In file included from fs/bcachefs/bcachefs.h:206,
                 from fs/bcachefs/btree_io.c:3:
fs/bcachefs/bcachefs_format.h:2344:21: note: while referencing 'start'
 2344 |  struct bkey_packed start[0];
      |                     ^~~~~

git bisect pointed to 5cfd69775eb5 ("bcachefs: Array bounds fixes").

I will be happy to test any patch or provide any extra log if needed.

#regzbot introduced: 5cfd69775eb5460ef78bb5034a37eb0dc52ab65d

-- 
Regards
Sudip
