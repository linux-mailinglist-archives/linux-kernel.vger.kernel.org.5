Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5527AD5CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjIYKYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjIYKY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:24:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDADCE;
        Mon, 25 Sep 2023 03:24:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85E9C433C9;
        Mon, 25 Sep 2023 10:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695637461;
        bh=xtN3D4LDUTuzosYJZbPIt8Z5GN0XuqQyg+i3+r1+uDg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZKRD+5pK4lzKLgR38tk5sKPQnKG/1rAffQZN9kAZ1SD7JgfqRN+VFCgPyxfdX8JDg
         BGiNbVmxYjXQW30mvuE8RntvGRm5iTnjxD7lO/RxwqCzEBf8QpuQQCWF+JMjB9XUuC
         xv1ibO3Ka64tGcoAJ3NVRakrdKi1GlcDz7e1otKVBg5sn4q9hIkbg6Wy9hj5ZMiNu3
         iZ8dXDIs9qMomVWxjOBKaIHZcNHmYQv0jNB+icS0hmrEbXYG5wCVownbvN26qUNl5R
         T+dShGaKk7Ud+jTKb2fHNkWp5fljDcvEDKtgocZ3UDVpz5gwxXsZuDDDSDp5PB+9MM
         fVt/IkG2Jpu8Q==
Message-ID: <09b36d06bf75aa8264ea31c76911bbd53ada6ab4.camel@kernel.org>
Subject: Re: [PATCH 1/2] fs/ceph/debugfs: make all files world-readable
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>,
        Max Kellermann <max.kellermann@ionos.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 Sep 2023 06:24:19 -0400
In-Reply-To: <fd88660f-0d23-16fb-2408-ac18ad01778e@redhat.com>
References: <20230922062558.1739642-1-max.kellermann@ionos.com>
         <fd88660f-0d23-16fb-2408-ac18ad01778e@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
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

On Mon, 2023-09-25 at 13:18 +0800, Xiubo Li wrote:
> On 9/22/23 14:25, Max Kellermann wrote:
> > I'd like to be able to run metrics collector processes without special
> > privileges
> >=20
> > In the kernel, there is a mix of debugfs files being world-readable
> > and not world-readable is; with a naive "git grep", I found 723
> > world-readable debugfs_create_file() calls and 582 calls which were
> > only accessible to privileged processe.
> >=20
> >  From the code, I cannot derive a consistent policy for that, but the
> > ceph statistics seem harmless (and useful) enough.
>=20
> I am not sure whether will this make sense. Because the 'debug' under=20
> '/sys/kernel/' is also only accessible by privileged process.
>=20
> Ilya, Jeff
>=20
> Any idea ?
>=20

Yeah, I don't think this makes much sense. At least on my machine:

# stat -c '%A' /sys/kernel/debug
drwx------

Without at least x permissions, an unprivileged user can't pathwalk
through there. Max, how are you testing this?


>=20
> > Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> > ---
> >   fs/ceph/debugfs.c | 18 +++++++++---------
> >   1 file changed, 9 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> > index 3904333fa6c3..2abee7e18144 100644
> > --- a/fs/ceph/debugfs.c
> > +++ b/fs/ceph/debugfs.c
> > @@ -429,31 +429,31 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *=
fsc)
> >   				       name);
> >  =20
> >   	fsc->debugfs_mdsmap =3D debugfs_create_file("mdsmap",
> > -					0400,
> > +					0444,
> >   					fsc->client->debugfs_dir,
> >   					fsc,
> >   					&mdsmap_fops);
> >  =20
> >   	fsc->debugfs_mds_sessions =3D debugfs_create_file("mds_sessions",
> > -					0400,
> > +					0444,
> >   					fsc->client->debugfs_dir,
> >   					fsc,
> >   					&mds_sessions_fops);
> >  =20
> >   	fsc->debugfs_mdsc =3D debugfs_create_file("mdsc",
> > -						0400,
> > +						0444,
> >   						fsc->client->debugfs_dir,
> >   						fsc,
> >   						&mdsc_fops);
> >  =20
> >   	fsc->debugfs_caps =3D debugfs_create_file("caps",
> > -						0400,
> > +						0444,
> >   						fsc->client->debugfs_dir,
> >   						fsc,
> >   						&caps_fops);
> >  =20
> >   	fsc->debugfs_status =3D debugfs_create_file("status",
> > -						  0400,
> > +						  0444,
> >   						  fsc->client->debugfs_dir,
> >   						  fsc,
> >   						  &status_fops);
> > @@ -461,13 +461,13 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *=
fsc)
> >   	fsc->debugfs_metrics_dir =3D debugfs_create_dir("metrics",
> >   						      fsc->client->debugfs_dir);
> >  =20
> > -	debugfs_create_file("file", 0400, fsc->debugfs_metrics_dir, fsc,
> > +	debugfs_create_file("file", 0444, fsc->debugfs_metrics_dir, fsc,
> >   			    &metrics_file_fops);
> > -	debugfs_create_file("latency", 0400, fsc->debugfs_metrics_dir, fsc,
> > +	debugfs_create_file("latency", 0444, fsc->debugfs_metrics_dir, fsc,
> >   			    &metrics_latency_fops);
> > -	debugfs_create_file("size", 0400, fsc->debugfs_metrics_dir, fsc,
> > +	debugfs_create_file("size", 0444, fsc->debugfs_metrics_dir, fsc,
> >   			    &metrics_size_fops);
> > -	debugfs_create_file("caps", 0400, fsc->debugfs_metrics_dir, fsc,
> > +	debugfs_create_file("caps", 0444, fsc->debugfs_metrics_dir, fsc,
> >   			    &metrics_caps_fops);
> >   }
> >  =20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
