Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C530F7A355D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 13:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjIQLik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 07:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjIQLiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 07:38:25 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC23211F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 04:38:19 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2749b3e682aso1613700a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 04:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694950699; x=1695555499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g9QH8hk/DgCKb1tbsqeV8sGSBePrOSPOK+lsRX0IiX8=;
        b=Hx58A5WzT5r3Jx342XeaVAbWXVwhV0LTyn02/BTBVQxKTcnLtdLi/1l2E7X8Zt6d+0
         tB1VsoHfh0djEGCYvnjDst9aTSVlvofYAk/XqV3wEtsNJQcp7BtzDr/TMQu630TcKSmm
         X129i8TuGZOdrmmJ+lv6coc9Cj5zFi+poGV8sQ5jGDZVEHlg3JiXyf9pSl3NXyySK1UM
         PMybdO8rEXps9nED4pt8sFdDkG2ac1tVbbNXjZtPzIcpc31TGgSKQp537ZEx2cKDPIct
         T3a59B31RgFLOOPYrR3xC32mflBvrBrKmXSEImIajDgC1sKkDWo5FEh79gzucQwR8nxl
         Wqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694950699; x=1695555499;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g9QH8hk/DgCKb1tbsqeV8sGSBePrOSPOK+lsRX0IiX8=;
        b=nfG6ZrwrdRAB4sBSbJrMNIUAG8OFDDLHGCU69UiTc6O0W+J2BJTOeHRLknKDhzhG4T
         ZPUNjN29f3XBQy9TpFsT/4QbXo3CbNuUq1Fh0sBVAdhfqLKd9KQOrzzuNNzmOPxIzfRj
         s5uNHBHriohbqI3hLZEcHSl6v8v/IcWle52HTL1UAIJhjVQhB7uCWwROnmE2AGxSqIoa
         WVMwy9sSGt8b/+AgKuNexaxHhP5B+QIwKTpUNHyCABpyb0cxY+kOvmNBHQX9Ez4ZMBDI
         EJOZfSbC7Mrznf7C9jrWTOQJWxa6s+QmNBJK0/XD2Q/L/2sjwISkWK2G7hbKtKQCPf9v
         fkLQ==
X-Gm-Message-State: AOJu0Yy06SXzWNyp1RhHb/UGKDjTv04XWw92FxMwt8LkzyjXMpfvuT/A
        x+x5AS2ykGt1Ik6TSSwmYaNubi0B7oN6X9FSLGfxfUCLLgE=
X-Google-Smtp-Source: AGHT+IEZD5rDvgyWFmwBa+YfdtdiE6Bth8swjZTr88VK8s99eGXnlOrzUbCRb+jIwutADn6OilB/0VjX7LP4mNsy7y4=
X-Received: by 2002:a17:90b:1495:b0:273:a392:7077 with SMTP id
 js21-20020a17090b149500b00273a3927077mr5737624pjb.10.1694950698816; Sun, 17
 Sep 2023 04:38:18 -0700 (PDT)
MIME-Version: 1.0
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sun, 17 Sep 2023 04:38:07 -0700
Message-ID: <CAMo8BfLb6U9xtMtt1t9vQX_nKek7kEt+Rvv5NwpvTHu0kdiXcg@mail.gmail.com>
Subject: /proc/*/maps broken on nommu
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As of v6.5 cat /proc/*/maps produces empty output on nommu xtensa systems.
Bisection points to the commit 0c563f148043 ("proc: remove VMA rbtree
use from nommu").
It looks like the issue may be not in the m_start (where find_vma(mm,
addr) returns
NULL), but in the nommu version of find_vma itself. I've tried replacing nommu
find_vma implementation with an implementation of the MMU version and it
fixes the /proc/*/maps output. Kind of (it works as expected on one of
my systems,
but consistently locks up on the other).

Any suggestions of what might be wrong/how to fix it properly?

-- 
Thanks.
-- Max
