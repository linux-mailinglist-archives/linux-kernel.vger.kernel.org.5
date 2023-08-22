Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB8F7848A8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjHVRs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHVRs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:48:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB76196
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:48:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BA2F641CA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 17:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BD7C433CB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 17:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692726535;
        bh=w9Vn+0wmdDc47W26xy7xzM3VjqdY3/VPTG/QkGXJykE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j9FOx3XQMJ09zN86UAzvfhihUMue6o2GbXPa+WG9RCiMiip//7Qw6kkVPAVFMx+of
         R3JyyYI0MZS+m9oX+Y5jRLDVqKrFqxhYJxLnvU2YALF5auAIz3J4rBHNj1bRJz2wXO
         0lsLR+C7fCgMmkIwsrQJf87TspFuhCHmn1w6bo8MXV6VANWY5xQKxIEbXqqJ2BlUgD
         vnmwaWoHYf4RP0LElWkyfMhK5y2NnXmxLjd9f8XVbLaZqVMP2hz2drULNPVsHupb9Q
         GOj6KvnyoMyWfsny4BSOuuFhuSmVjFSI9s2zSxOluVytxCq8HJDfGYQWg59vgowXh4
         nVkSBji5lpnpg==
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5656a5c6721so2708032a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:48:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YzB00B+ALd/k51YTl4MVjEsa1EZXKgJUc3DVux4ctQfxLHBJDvy
        QH7ykWCjSounPZxZP4Oo/79EsCQIhjazE6IU+hL6vA==
X-Google-Smtp-Source: AGHT+IGYboLBu89CyJdjRREQ6M0SNQNS/hg8f+2pjm2pJGOFiGOfrk5Dt/V5+tQsbJk3Tvv3+HxYleqkq7UXklVXBIc=
X-Received: by 2002:a17:90a:ead0:b0:26b:13b7:22f9 with SMTP id
 ev16-20020a17090aead000b0026b13b722f9mr6574110pjb.22.1692726535057; Tue, 22
 Aug 2023 10:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230817-free_pcppages_bulk-v1-0-c14574a9f80c@kernel.org> <20230821103225.qntnsotdzuthxn2y@techsingularity.net>
In-Reply-To: <20230821103225.qntnsotdzuthxn2y@techsingularity.net>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 22 Aug 2023 10:48:42 -0700
X-Gmail-Original-Message-ID: <CAF8kJuOsWo5RfDcfnWZfnqYXjf6bkkxdXG1JCwjaEZ1nn29AaA@mail.gmail.com>
Message-ID: <CAF8kJuOsWo5RfDcfnWZfnqYXjf6bkkxdXG1JCwjaEZ1nn29AaA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] mm/page_alloc: free_pcppages_bulk safeguard
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        baolin.wang@linux.alibaba.com, Michal Hocko <mhocko@suse.com>,
        david@redhat.com, willy@infradead.org, linux-mm@kvack.org,
        Namhyung Kim <namhyung@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        John Sperbeck <jsperbeck@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

Adding Alexei to the discussion.

On Mon, Aug 21, 2023 at 3:32=E2=80=AFAM Mel Gorman <mgorman@techsingularity=
.net> wrote:
>
> On Thu, Aug 17, 2023 at 11:05:22PM -0700, Chris Li wrote:
> > In this patch series I want to safeguard
> > the free_pcppage_bulk against change in the
> > pcp->count outside of this function. e.g.
> > by BPF program inject on the function tracepoint.
> >
> > I break up the patches into two seperate patches
> > for the safeguard and clean up.
> >
> > Hopefully that is easier to review.
> >
> > Signed-off-by: Chris Li <chrisl@kernel.org>
>
> This sounds like a maintenance nightmare if internal state can be arbitra=
ry
> modified by a BPF program and still expected to work properly in all case=
s.
> Every review would have to take into account "what if a BPF script modifi=
es
> state behind our back?"

Thanks for the feedback.

I agree that it is hard to support if we allow BPF to change any internal
stage as a rule.  That is why it is a RFC. Would you consider it case
by case basis?
The kernel panic is bad, the first patch is actually very small. I can
also change it
to generate warnings if we detect the inconsistent state.

How about the second (clean up) patch or Keming's clean up version? I can m=
odify
it to take out the pcp->count if the verdict is just not supporting
BPF changing internal
state at all. I do wish to get rid of the pindex_min and pindex_max.

Thanks

Chris
