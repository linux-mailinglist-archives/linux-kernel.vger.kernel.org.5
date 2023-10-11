Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF277C4B39
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344526AbjJKHHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344306AbjJKHHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:07:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BABA98
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:07:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so1092483366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1697008065; x=1697612865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qZdr/OmU9//AzD2PL83jeMNBa/vNjL57DmBMZIx5BPA=;
        b=khQutv74qGy4Ky371n0aV2Njy1qeUQDhGH1p8h48RIuSEE0wJA9NvgYoZzyk7+awU8
         qEOX9+SZBKMQYB/jazn3Cj6454OizTpo3g6moxGsuB720Lh+uHrutabg16CbkHm9QzGG
         MrEHcdPwipFg6B+QaHuvkDEVElysK+hiew54Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697008065; x=1697612865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZdr/OmU9//AzD2PL83jeMNBa/vNjL57DmBMZIx5BPA=;
        b=xLwnzcZMuDombpScnIlPuhkt071Bq9B8jNs0ERw9eWJCOxlOLQegGN7ZYHrSgtD9bI
         x5cgUN3Fiwk0jHUhUiWK6yPUqdZoivg/I46ElUDnhEyqB+urpZ6XJQkJ7XpWyywGeaPU
         zKKyBA2RFdbFVV9wnEdfV17HfKFZmNn539DMPEwRzZ8aIW2tilZVrRJtJ8KU4Il2fD+Z
         sGMyHYv9QQC65wr8AuD9qfgTktCNKskgZM6QkJc4uBa89JCHaHjXIKNzt3i0Cn5auICM
         6YfPElvzTcwnq1OwqT9JXvD57A+B6EyWIJni6fMLqJFevy5EKOXX/Po5OcQ1SUL3CWai
         8ejA==
X-Gm-Message-State: AOJu0YwU2DdCSxLfIsJIPJH8m94lKPq2ke2lV9oCrf3SVSaUmv0VruVn
        cQpaHEab02S0+eY+ED9oPnTvPdXSfP5hscHpvKiD+Q==
X-Google-Smtp-Source: AGHT+IHxSFAWoxypAIR4Zn2MKcRaxT5uvo/oC0sGn2qRZ1uoaS2bzlqSGyqodwewEcMa6l0D40uGq3seGQXqZBSKu4A=
X-Received: by 2002:a17:906:8465:b0:9b2:8b14:7a3d with SMTP id
 hx5-20020a170906846500b009b28b147a3dmr19127877ejc.4.1697008065009; Wed, 11
 Oct 2023 00:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696043833.git.kjlx@templeofstupid.com> <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
 <CAJfpegtOdqeK34CYvBTuVwOzcyZG8hnusiYO05JdbATOxfVMOg@mail.gmail.com>
 <20231010023507.GA1983@templeofstupid.com> <CAJfpegvr0cHj53jSPyBxVZnMpReq_RFhT-P1jv8eUu4pqxt9HA@mail.gmail.com>
 <20231011012545.GA1977@templeofstupid.com>
In-Reply-To: <20231011012545.GA1977@templeofstupid.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 11 Oct 2023 09:07:33 +0200
Message-ID: <CAJfpegukL5bj6U0Kvvw_uTW1jstoD2DTLM7kByx2HAhOP02HEg@mail.gmail.com>
Subject: Re: [resend PATCH v2 2/2] fuse: ensure that submounts lookup their parent
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 03:26, Krister Johansen <kjlx@templeofstupid.com> wrote:

> I am curious what you have in mind in order to move this towards a
> proper fix?  I shied away from the approach of stealing a nlookup from
> mp_fi beacuse it wasn't clear that I could always count on the nlookup
> in the parent staying positive.  E.g. I was afraid I was either going to
> not have enough nlookups to move to submounts, or trigger a forget from
> an exiting container that leads to an EBADF from the initial mount
> namespace.

One idea is to transfer the nlookup to a separately refcounted object
that is referenced from mp_fi as well as all the submounts.

Thanks,
Miklos
