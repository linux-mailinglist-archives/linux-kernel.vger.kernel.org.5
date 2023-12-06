Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D613C806550
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjLFC6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFC6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:58:07 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF831B5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 18:58:13 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-423dcd5d060so2728871cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 18:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701831492; x=1702436292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+W/qJKZ4cbrJ9KJlY0HysuZCkaE03MWjevhyEtd/+k=;
        b=C043Y/o3nmZqO5drW/ytixLfQ3/Yg2tetNJ0mozl0W+LJt8PrvkZDAAIKO//77o7xS
         0vqPrnh0AqwIRYO3RKVoC5ULQcJfkvb/hru7xXNasnVGsAPahqk16ksdIVuzY9m7ZPUf
         re6qs37H9QdFVzcLsxMv/4Ias8TG8Qd/jvNo8H4/2IcQN9MMZn/cSe+z1fFc/AOMpi9n
         x8wq5qimJhIL8H4RTe1di1VNm1dSN2c6r0v68/rRjx1+NtfNHJ8swQDXd5oHh8enH4Mr
         N8/keY1Gykp3G+pSqxTDs5MRp9GN0a8yzS7JrndjN7fO4b3X3N6pGougdIX03jUMTvQn
         ZXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701831492; x=1702436292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+W/qJKZ4cbrJ9KJlY0HysuZCkaE03MWjevhyEtd/+k=;
        b=nNz3Gq8DU2q0rYGTQ/i33p5jxSTd1plRMcuXmPDuBRzEgwqWdBVoyWK2tXiS+mOVUE
         fVh7i8B5ka1SxIcGpvNXVEA3kaQkBtA/WsfPoZau5+fgZPt4RcVpA2CLApmMU/Clq+8S
         B/uE0z/AESKDUuKxoFvGS1UQuX29TmsiffwbEGWSbJM4BlekBJzfIZ45ZPGURi5VK0zc
         D6CI18K8VAqvJr6GQptNXh+qP/WXTcIUkdtXtFJ5nnds5UInYYJFJ61Te4UgGh5c7skB
         FVX+boDHSZr57oFMq6t0D0avMw8XFQ4F+R6CSmcp73GR2vt0PAc+UxQ2u2MRpjf/84so
         uBcQ==
X-Gm-Message-State: AOJu0YyWC9Kn2Py6MhGvdmg9lsT4kNTupCdQWUad0YOgg+ucCFIObsei
        t1w/K1PblfOX4h6aDsdLSSEB/+rWAThodKnChH6dRQ==
X-Google-Smtp-Source: AGHT+IF/PbeDPHGTwTbaA2pV4mOFvfRBSKmJB7XTO8IsjUWL5YNJ6TW8QV1NfT/POdd4ka0OvkcYQJe1EpzjjtkHa0g=
X-Received: by 2002:a05:622a:1315:b0:425:4420:c176 with SMTP id
 v21-20020a05622a131500b004254420c176mr3223260qtk.27.1701831492370; Tue, 05
 Dec 2023 18:58:12 -0800 (PST)
MIME-Version: 1.0
References: <20231205223118.3575485-1-souravpanda@google.com> <2023120648-droplet-slit-0e31@gregkh>
In-Reply-To: <2023120648-droplet-slit-0e31@gregkh>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 5 Dec 2023 21:57:36 -0500
Message-ID: <CA+CK2bARjZgnMBL9bOD7p1u=02-fGgWwfiGvsFVpsJWL-VR2ng@mail.gmail.com>
Subject: Re: [PATCH v6 0/1] mm: report per-page metadata information
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sourav Panda <souravpanda@google.com>, corbet@lwn.net,
        rafael@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev, rppt@kernel.org,
        david@redhat.com, rdunlap@infradead.org, chenlinxuan@uniontech.com,
        yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
        bhelgaas@google.com, ivan@cloudflare.com, yosryahmed@google.com,
        hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, weixugc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Sourav removed the new field from sys/device../nodeN/meminfo as you
requested; however, in nodeN/vmstat fields still get appended, as
there is code that displays every item in zone_stat_item,
node_stat_item without option to opt-out. I mentioned it to you at
LPC.

In my IOMMU [1] series, there are also fields that are added to
node_stat_item that as result are appended to nodeN/vmstat.

Pasha

[1] https://lore.kernel.org/all/20231130201504.2322355-1-pasha.tatashin@sol=
een.com

On Tue, Dec 5, 2023 at 9:36=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Tue, Dec 05, 2023 at 02:31:17PM -0800, Sourav Panda wrote:
> > Changelog:
> > v6:
> >       - Interface changes
> >               - Added per-node nr_page_metadata and
> >                 nr_page_metadata_boot fields that are exported
> >                 in /sys/devices/system/node/nodeN/vmstat
>
> Again, please do not add any new fields to existing sysfs files, that's
> not going to work well.  You can add a new sysfs file, that's file, but
> do not continue the abuse of the sysfs api in this file.
>
> thanks,
>
> greg k-h
