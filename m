Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB947C4474
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343968AbjJJWn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjJJWn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:43:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1DEDD
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:43:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b64b98656bso1052346466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696977802; x=1697582602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=626B9wgJ8h02KW46+tnnnyuQPSu/ZwIJyUI7faTL3rc=;
        b=jfbUoSbDgKMgDfWBhgY0uZVFLrf7vN6BIPVrJbT81JkvehIVroIwvie0YJraSysqpl
         3V9r9SkFARN534PaxtNR+OoeAsaS1iiNfNvJmMY0YJ3wI5Wq54Dh2j3TZznGHcXx2lLf
         coqCIn74F6NuRn5GZX2skCwJYgk9pMmDLoLGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696977802; x=1697582602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=626B9wgJ8h02KW46+tnnnyuQPSu/ZwIJyUI7faTL3rc=;
        b=fPwq56+ObhnonTKy1imdcQKGLhlM01L1sNr3NXtL5sO+tCQsaAffsEhJO+YKKW+YhR
         SdJXRgdv00UFtN6Zqp53sRkFp3K0aApQdRBQDzQ9f19dBmt4g/jUOLDa4JLhr4n9rWtP
         Qhq1qh8r4QXQaDTL+3bDpXCCWkvTAyE64Mp9Jz4vcVGSbDK2h3cs0ct+0ZF26IYKiSQA
         JbmAg8dtV/wsHsHOUDXop+RYUAQbxB3OART9Vb47FG2NidWj/dCKy1v8n9AR5zOPyiG3
         VjNr3isLU1RRDVW+NPuEG5j7Wl+E4MP13n+eiZojUvp+J7C+EeclBLnIPLsaj7rD8t1C
         cbIA==
X-Gm-Message-State: AOJu0Yz70ysZQqFbcalq4OZ3GA35j4sXizkAlfgSIG1o26L9Ze69gLbv
        lWYKxhiS7fZqwL5ipFI5sTIB1JuiJ2UtaPsZVccBIg==
X-Google-Smtp-Source: AGHT+IH70mmZj2zKOy8nY6IG+ffXvimPYzar2rp3E5IPY2l9DVvHPtfuYBDsCXWHKWCzN+3Xn0WYAEez4zqxgNr6W3Q=
X-Received: by 2002:a17:907:780d:b0:9b6:4df9:e5b5 with SMTP id
 la13-20020a170907780d00b009b64df9e5b5mr17511207ejc.61.1696977802200; Tue, 10
 Oct 2023 15:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
 <20231007012817.3052558-4-sarthakkukreti@chromium.org> <ZSM9UDMFNs0050pr@dread.disaster.area>
In-Reply-To: <ZSM9UDMFNs0050pr@dread.disaster.area>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Tue, 10 Oct 2023 15:43:10 -0700
Message-ID: <CAG9=OMNPK2s4vsun4B=xQ9nt3qR_fevNP1zSkYq9YG5QPPTsfQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] loop: Add support for provision requests
To:     Dave Chinner <david@fromorbit.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 8, 2023 at 4:37=E2=80=AFPM Dave Chinner <david@fromorbit.com> w=
rote:
>
> On Fri, Oct 06, 2023 at 06:28:15PM -0700, Sarthak Kukreti wrote:
> > Add support for provision requests to loopback devices.
> > Loop devices will configure provision support based on
> > whether the underlying block device/file can support
> > the provision request and upon receiving a provision bio,
> > will map it to the backing device/storage. For loop devices
> > over files, a REQ_OP_PROVISION request will translate to
> > an fallocate mode 0 call on the backing file.
> >
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>
>
> Hmmmm.
>
> This doesn't actually implement the required semantics of
> REQ_PROVISION. Yes, it passes the command to the filesystem
> fallocate() implementation, but fallocate() at the filesystem level
> does not have the same semantics as REQ_PROVISION.
>
> i.e. at the filesystem level, fallocate() only guarantees the next
> write to the provisioned range will succeed without ENOSPC, it does
> not guarantee *every* write to the range will succeed without
> ENOSPC. If someone clones the loop file while it is in use (i.e.
> snapshots it via cp --reflink) then all guarantees that the next
> write to a provisioned LBA range will succeed without ENOSPC are
> voided.
>
> So while this will work for basic testing that the filesystem is
> issuing REQ_PROVISION based IO correctly, it can't actually be used
> for hosting production filesystems that need full REQ_PROVISION
> guarantees when the loop device backing file is independently
> shapshotted via FICLONE....
>
> At minimuim, this set of implementation constraints needs tobe
> documented somewhere...
>
Fair point. I wanted to have a separate fallocate() mode
(FALLOC_FL_PROVISION) in the earlier series of the patchset so that we
can distinguish between a provision request and a regular fallocate()
call; I dropped it from the series after feedback that the default
case should suffice. But this might be one of the cases where we need
an explicit intent that we want to provision space.

Given a separate FALLOC_FL_PROVISION mode in the scenario you
mentioned, the filesystem could copy previously 'provisioned' blocks
to new blocks (which implicitly provisions them) or reserve blocks for
use (and passing through REQ_OP_PROVISION below). That also means that
the filesystem should track 'provisioned' blocks and take appropriate
actions to ensure the provisioning guarantees.

For filesystems without copy-on-write semantics (eg. ext4),
REQ_OP_PROVISION should still be equivalent to mode =3D=3D 0.

For now, I'll add the details to the commit message and the loop
driver code (side note: should there be device documentation on the
loop device driver?). WDYT?

Best
Sarthak

> -Dave.
> --
> Dave Chinner
> david@fromorbit.com
