Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A63F7E82AC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346311AbjKJTWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjKJTWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:22:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF558B9CB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699643770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GxHfJ1htVRZCy6QGeX5s9dQZAX+xioUFSgZZ1hMauTk=;
        b=SBFmwd3+Zn6DrlKo50on1EuhdYslwHLGXE5o8kPuQ0Hb9cEF9L7Oad1meknlnHiR9zi2ga
        IuqhFNbi0aXNrOoFP9ANSv7PCRwrsAYZuzdYZKE+Xfkv6uuMkpQZM/wSl4c/fmJRBec7gj
        7SY+QiF9z7564TVoT5j3LXQCnhNsvg8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-7EhilaGZOQ260lSm46xiDg-1; Fri, 10 Nov 2023 14:16:09 -0500
X-MC-Unique: 7EhilaGZOQ260lSm46xiDg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6754babc2c8so2425296d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699643768; x=1700248568;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GxHfJ1htVRZCy6QGeX5s9dQZAX+xioUFSgZZ1hMauTk=;
        b=Ae/fj6WxqCPEy1aOBL8bCXc8mVaUqbAK0ZM2W5JvUx1Z8hw/9VcjcjsBaaDj8YmanW
         cKsnGoglhDGrsIfLBJYaEoxeJd9I8ytq9mWwWU/4ehGz3PLIUG0o7Cf3jwgObwzLpIVh
         t/ck4cb1gObQkirZOrECLrYReCrPeUWNNhXveJMNNskyiKxiKC7jSoDHnQzhbJqrUVyO
         32MzoEvA0fqwAJBa8H9an4zjxvMbNPwf0Ny1EDOyZeLB1JmZ9XBZy3a7sE31s+JTX3z4
         zxlJ7tYSxzwHWxu9ZFRVi9gEqUFqLuTUFBAKZqi/KnY/CRdPpE8B7OXt25cQ9srGalS/
         KDsQ==
X-Gm-Message-State: AOJu0YxJ0/yvxBUi7Gdtep/3rWXHfOtiVzn9cpVXTKTbkFjIhD4RLnTU
        T97Jqt6FD+SBv86UEtEWdLwjvng9KJEipjF4Lnc+Yxd+VT6bGGhypaTxOfOoP5bTb5Em4Ix3qba
        k85h0eqgDPO+zlPFvsomVObt9Oa9nhnCZ
X-Received: by 2002:ad4:5911:0:b0:66a:d2d2:59b6 with SMTP id ez17-20020ad45911000000b0066ad2d259b6mr93446qvb.5.1699643768668;
        Fri, 10 Nov 2023 11:16:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFi1+TSOIQnmNjS0gFPLLySwN8wyJkIMgU/AagS1/+hxuZ+LJtxfrdJv5Rn17oTFgSYMv2bag==
X-Received: by 2002:ad4:5911:0:b0:66a:d2d2:59b6 with SMTP id ez17-20020ad45911000000b0066ad2d259b6mr93433qvb.5.1699643768416;
        Fri, 10 Nov 2023 11:16:08 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32e5:ff00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id e11-20020a056214162b00b0066d0621bb67sm50370qvw.114.2023.11.10.11.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 11:16:08 -0800 (PST)
Message-ID: <5c547e6de1e6c206a46197c8f46583e0bc5f4395.camel@redhat.com>
Subject: Re: Implementation details of PCI Managed (devres) Functions
From:   Philipp Stanner <pstanner@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <htejun@gmail.com>, dakr@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>, jeff@garzik.org,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri, 10 Nov 2023 20:16:05 +0100
In-Reply-To: <ZU0qYBfFzsF3e8S9@slm.duckdns.org>
References: <84be1049e41283cf8a110267646320af9ffe59fe.camel@redhat.com>
         <1e964a74ca51e9e28202a47af22917e468050039.camel@redhat.com>
         <ZU0qYBfFzsF3e8S9@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Thu, 2023-11-09 at 08:52 -1000, Tejun Heo wrote:
> Hello, Philipp.
>=20
> On Wed, Nov 08, 2023 at 10:02:29PM +0100, Philipp Stanner wrote:
> ...
> > That struct keeps track of the requested BARs. That's why there can
> > only be one mapping per BAR, because that table is statically
> > allocated
> > and is indexed with the bar-number.
> > pcim_iomap_table() now only ever returns the table with the
> > pointers to
> > the BARs. Adding tables to that struct that keep track of which
> > mappings exist in which bars would be a bit tricky and require
> > probably
> > an API change for everyone who currently uses pcim_iomap_table(),
> > and
> > that's more than 100 C-files.
> >=20
> > So, it seems that a concern back in 2007 was to keep things simple
> > and
> > skip the more complex data structures necessary for keeping track
> > of
> > the various mappings within a bar.
>=20
> It was so long ago that I don't remember much but I do remember
> taking a
> shortcut there for convenience / simplicity. I'm sure it's already
> clear but
> there's no deeper reason, so if you wanna put in the work to make it
> consistent, that'd be great.
>=20

Alright, it's good to know that there seems to be no functional or
semantic reason or something behind it.

I'll think it through. Maybe we can design something clever

P.


> Thanks.
>=20

