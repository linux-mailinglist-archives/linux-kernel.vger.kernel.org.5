Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401CC80F71B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377277AbjLLTpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjLLTpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:45:38 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05099A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:45:44 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-58dd3528497so3702458eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702410344; x=1703015144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqpE4b9HeVSGikGGqeFsJ4KywhPDheldl45r4Yspt1s=;
        b=i8u5UfXo6biNyk/8fSn10Oxe5R/rcnjAgsyRVUYzstlYtpCS8I+S7uoIP9CMXdy8o5
         V13OxAj6Rw20YY9xDrZyqQwAAv5m1gVsIo7hTzvb/xTQalGmomSlYgw+Sn/vahtVOD46
         tInz64T5bBEDxjU1TrCy4WlmggVVO1vnpK956z0296xz7Qpr9SKCHpFpYRGPLq9/rf45
         suBn1TtXcCnn7LLBfv3yXVsWcjY5y0cbpX0qnq1Ig+rzTJKem32IwVmlDmoBNXXTn4iw
         Y4yqJNpZcagcVhr5F80TMxT3C3CIZJer9pv9sZdLXxJEyRDrzieSzQx10qZFPFVV7oVm
         fi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702410344; x=1703015144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqpE4b9HeVSGikGGqeFsJ4KywhPDheldl45r4Yspt1s=;
        b=J8zCx/y7t636JnNJqFNCRK9c7sz7X3u9MncDDlI657EBwM3aKrAe23qTN2WY5gtv1t
         5QoqikCgUSoT52FK2PgfLdSI/FOXyZ5kYTLD1Vg/uVSAg1BiHF8rIYSrcS9Kg26Mp8Zg
         NNTDw78W7GUCej7cmRvn4wxidHefQN/cmo/925Coxzga2dgXFU3wuISJtRIHLLEtBDeb
         YWEcTJB6ziiD1nzQTt61kjVkiEhYbr80jjNtHx7dOWGP7vv3wbuHXHs7StYmfu7ajLAA
         4E+/FieievD67z+xsfE110i7pe6bZiEbB9EdHKQJQrjcKTrkwEjadhYL1dtc6K7+weDL
         +Eag==
X-Gm-Message-State: AOJu0YwDE2UPvBss77qIt4nwQXEHrosX4vEU71EvFg8wNq/56K7/umlZ
        eGlE+6yGc1N4k5Rq9UzyHyvy+e+amGJlDwNMBXwnLg==
X-Google-Smtp-Source: AGHT+IE5HN38n8+3SsAmeUbOGWSras3uemG0+6v7okLB2alcrW8Mg7C7PIQ/RFU07BFoXU4w+0bpfT+i5Nv0NX+r4Ok=
X-Received: by 2002:a05:6820:826:b0:58d:713d:a003 with SMTP id
 bg38-20020a056820082600b0058d713da003mr5029156oob.3.1702410343848; Tue, 12
 Dec 2023 11:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20231211193048.580691-1-avagin@google.com> <20231211193048.580691-2-avagin@google.com>
In-Reply-To: <20231211193048.580691-2-avagin@google.com>
From:   Andrei Vagin <avagin@google.com>
Date:   Tue, 12 Dec 2023 11:45:33 -0800
Message-ID: <CAEWA0a5t=7U3xNKDDH36Z_37Xereosy49fz4q3pV=j0bCOjDZg@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/overlayfs: verify device and inode numbers
 in /proc/pid/maps
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 11:30=E2=80=AFAM Andrei Vagin <avagin@google.com> w=
rote:
> +static long get_file_dev_and_inode(void *addr, struct statx *stx)
> +{
> +       char buf[4096];
> +       FILE *mapf;
> +
> +       mapf =3D fopen("/proc/self/maps", "r");
> +       if (mapf =3D=3D NULL)
> +               return pr_perror("fopen(/proc/self/maps)");
> +
> +       while (fgets(buf, sizeof(buf), mapf)) {
> +               unsigned long start, end;
> +               uint32_t maj, min;
> +               __u64 ino;
> +
> +               if (sscanf(buf, "%lx-%lx %*s %*s %x:%x %llx",
> +                               &start, &end, &maj, &min, &ino) !=3D 5)

inode is shown in the decimal format, so the last %llx has to be
replaced with %llu.
I will resend this test in reply to Amir's version of the first patch.

Thanks,
Andrei
