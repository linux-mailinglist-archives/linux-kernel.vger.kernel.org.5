Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8E67AD6FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjIYL3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjIYL3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:29:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF22AC6;
        Mon, 25 Sep 2023 04:29:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4144C433C7;
        Mon, 25 Sep 2023 11:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695641385;
        bh=2MbEYpOL+kd6uNyBjo39tKu41KpsEJTkTcuCbFCeUq0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OJ/NxX7VJvEsz87o5ht+Ojr5ufUFRCLMBwIy+Zn13UfOrKeKaPB+aVXcYi21Y0lvy
         bXo3e6n8bLYckQRqGdCFepp+fLSC7444BSdphs37MNFAIqLQ7hY2qwF7e7OWtFOdtZ
         mwi4r8UvKqaZTdl+xVogqFYZT+agL/hQN4dmUcMMrvrzTqs5E+Uis1L9IiryKn6Ma/
         Kr5u3K3Tny8npDHJlyhyBKEOSCjs2iamv9mTMK3QXoXOhx6y4zIj0eJbDFKkmTGC/Y
         aaODfwRzkNwxRUxAl64k2XHJKp4aFI0bh/jRjCEnPkDrqY20hordyTKTvDdwXX9ZEP
         oAA5aO0qEN8CQ==
Message-ID: <fd19d9585b29952fcd727c1a6c47289f66ab96b7.camel@kernel.org>
Subject: Re: [PATCH 1/2] fs/ceph/debugfs: make all files world-readable
From:   Jeff Layton <jlayton@kernel.org>
To:     Ilya Dryomov <idryomov@gmail.com>,
        Max Kellermann <max.kellermann@ionos.com>
Cc:     Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Mon, 25 Sep 2023 07:29:43 -0400
In-Reply-To: <CAOi1vP80WvQhuXgzhvzupQP=4K2ckgu_WpUCtUSy5M+QdDycqw@mail.gmail.com>
References: <20230922062558.1739642-1-max.kellermann@ionos.com>
         <CAOi1vP80WvQhuXgzhvzupQP=4K2ckgu_WpUCtUSy5M+QdDycqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-25 at 12:41 +0200, Ilya Dryomov wrote:
> On Fri, Sep 22, 2023 at 8:26=E2=80=AFAM Max Kellermann <max.kellermann@io=
nos.com> wrote:
> >=20
> > I'd like to be able to run metrics collector processes without special
> > privileges
>=20
> Hi Max,
>=20
> A word of caution about building metrics collectors based on debugfs
> output: there are no stability guarantees.  While the format won't be
> changed just for the sake of change of course, expect zero effort to
> preserve backwards compatibility.
>=20
> The latency metrics in particular are sent to the MDS in binary form
> and are intended to be consumed through commands like "ceph fs top".
> debugfs stuff is there just for an occasional sneak peek (apart from
> actual debugging).
>=20

FWIW, I wish we had gone with netlink for this functionality instead of
a seqfile. Lorenzo has been working with netlink for some similar
functionality with nfsd[1], and it's much nicer for this sort of thing.

[1]: https://lore.kernel.org/linux-nfs/ZQTM6l7NrsVHFoR5@lore-desk/T/#t

--=20
Jeff Layton <jlayton@kernel.org>
