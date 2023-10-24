Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4707D5057
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbjJXMx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbjJXMx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:53:56 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8EC90
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=RmLarUo7D/BXs7zx6nAos+1yGhe5BOkCbiwZbs9L0h0=; b=lNfXVsDOXtd9alDSiEMenIba7Z
        OvnWE4Z/42OjBlG3VvSN5rl5TIfiOf5zhT6qe9txA17Kvv6YKEsDXjtmCS2yD51hAORCj5SdQNKb5
        fBdpheuDP3dOFNuyBoOuZpOcJcLYtoXihXdiF5145mWIQRhQoellcKtUtXdywJjTpcXw4HbfXzUPi
        JLM9x5kZ5pkTpKBIijZfpthvQ3GxkBXf9zA+zDCOg4q++vTUSVBRlDr5r3qk2QFyRtBW6W+JirIlj
        Z1SUpIDiKFzq+M/hu9pvgM0HVaGX56mwBQMsjCyDHd8GO/tTCvE2C29WB2TDk/YIgOq0QvqtPMQIN
        VYurRKQIhhr4X8l+zAsPo3hLUh4dAVBktigpJQ6cubiuNZXzl1Goz1KusRnlvtKmJPI01/aOFfdLm
        cgu5RTxGGg+nb6blgSHTsv+dlIOWkWaG3vvxd387x2H+8jj8pEbArfX3iJLueWmiCD/BywGKlZ9lz
        38XO/eZ9MQYp+oFkPRzkLz5FL0Pd8tonKanpEgnm5nLbCB1u9J2QkaCF5o3MZLf8+xyCK1xvUU55c
        8bHXoGI/ZTAxFEq3dYrguPlnBKwM13Jb1TD/+I4qciq3+joIi0VqekZbx/pLPHf6qg42ZX33TOv1L
        KRkyFLQvXuC5zQ5OSs1fk2Ak4EmcfPELXEpPmwJqg=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     v9fs@lists.linux.dev, ericvh@kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     lucho@ionkov.net, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 3/3] 9p/net: xen: fix false positive printf format overflow
 warning
Date:   Tue, 24 Oct 2023 14:52:53 +0200
Message-ID: <4016006.DBIyO7nNK6@silver>
In-Reply-To: <20231023233704.1185154-4-asmadeus@codewreck.org>
References: <20231023233704.1185154-1-asmadeus@codewreck.org>
 <20231023233704.1185154-4-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 24, 2023 1:37:04 AM CEST Dominique Martinet wrote:
> Use a local variable to make the compiler happy about this warning:
> net/9p/trans_xen.c: In function =E2=80=98xen_9pfs_front_changed=E2=80=99:
> net/9p/trans_xen.c:444:39: warning: =E2=80=98%d=E2=80=99 directive writin=
g between 1 and 11 bytes into a region of size 8 [-Wformat-overflow=3D]
>   444 |                 sprintf(str, "ring-ref%d", i);
>       |                                       ^~
> In function =E2=80=98xen_9pfs_front_init=E2=80=99,
>     inlined from =E2=80=98xen_9pfs_front_changed=E2=80=99 at net/9p/trans=
_xen.c:516:8,
>     inlined from =E2=80=98xen_9pfs_front_changed=E2=80=99 at net/9p/trans=
_xen.c:504:13:
> net/9p/trans_xen.c:444:30: note: directive argument in the range [-214748=
3644, 2147483646]
>   444 |                 sprintf(str, "ring-ref%d", i);
>       |                              ^~~~~~~~~~~~
> net/9p/trans_xen.c:444:17: note: =E2=80=98sprintf=E2=80=99 output between=
 10 and 20 bytes into a destination of size 16
>   444 |                 sprintf(str, "ring-ref%d", i);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> net/9p/trans_xen.c: In function =E2=80=98xen_9pfs_front_changed=E2=80=99:
> net/9p/trans_xen.c:450:45: warning: =E2=80=98%d=E2=80=99 directive writin=
g between 1 and 11 bytes into a region of size 2 [-Wformat-overflow=3D]
>   450 |                 sprintf(str, "event-channel-%d", i);
>       |                                             ^~
> In function =E2=80=98xen_9pfs_front_init=E2=80=99,
>     inlined from =E2=80=98xen_9pfs_front_changed=E2=80=99 at net/9p/trans=
_xen.c:516:8,
>     inlined from =E2=80=98xen_9pfs_front_changed=E2=80=99 at net/9p/trans=
_xen.c:504:13:
> net/9p/trans_xen.c:450:30: note: directive argument in the range [-214748=
3644, 2147483646]
>   450 |                 sprintf(str, "event-channel-%d", i);
>       |                              ^~~~~~~~~~~~~~~~~~
> net/9p/trans_xen.c:450:17: note: =E2=80=98sprintf=E2=80=99 output between=
 16 and 26 bytes into a destination of size 16
>   450 |                 sprintf(str, "event-channel-%d", i);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> There is no change in logic: there only are a constant number of rings,
> and there also already is a BUILD_BUG_ON that checks if that constant
> goes over 9 as anything bigger would no longer fit the event-channel-%d
> destination size.
>=20
> In theory having that size as part of the struct means it could be
> modified by another thread and makes the compiler lose track of possible
> values for 'i' here, using a local variable makes it happy.

Or ... what about dropping struct's 'num_rings' member and using the consta=
nt
XEN_9PFS_NUM_RINGS everywhere instead? As this is really a compile-time val=
ue
after all.

> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> While looking at warnings with W=3D1, I noticed this one in net/9p.
>=20
> This is silly but shouldn't hurt, num_rings is never changed so there is
> no risk of introducing a race here, it's just helping the compiler a
> bit.
>=20
> net/9p is also now warning-free at W=3D1
>=20
>  net/9p/trans_xen.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
> index 1fffe2bed5b0..79e91f31a84a 100644
> --- a/net/9p/trans_xen.c
> +++ b/net/9p/trans_xen.c
> @@ -382,7 +382,7 @@ static int xen_9pfs_front_init(struct xenbus_device *=
dev)
>  	struct xenbus_transaction xbt;
>  	struct xen_9pfs_front_priv *priv =3D dev_get_drvdata(&dev->dev);
>  	char *versions, *v;
> -	unsigned int max_rings, max_ring_order, len =3D 0;
> +	unsigned int num_rings, max_rings, max_ring_order, len =3D 0;
> =20
>  	versions =3D xenbus_read(XBT_NIL, dev->otherend, "versions", &len);
>  	if (IS_ERR(versions))
> @@ -408,15 +408,15 @@ static int xen_9pfs_front_init(struct xenbus_device=
 *dev)
>  	if (p9_xen_trans.maxsize > XEN_FLEX_RING_SIZE(max_ring_order))
>  		p9_xen_trans.maxsize =3D XEN_FLEX_RING_SIZE(max_ring_order) / 2;
> =20
> -	priv->num_rings =3D XEN_9PFS_NUM_RINGS;
> -	priv->rings =3D kcalloc(priv->num_rings, sizeof(*priv->rings),
> +	num_rings =3D priv->num_rings =3D XEN_9PFS_NUM_RINGS;
> +	priv->rings =3D kcalloc(num_rings, sizeof(*priv->rings),
>  			      GFP_KERNEL);
>  	if (!priv->rings) {
>  		kfree(priv);
>  		return -ENOMEM;
>  	}
> =20
> -	for (i =3D 0; i < priv->num_rings; i++) {
> +	for (i =3D 0; i < num_rings; i++) {
>  		priv->rings[i].priv =3D priv;
>  		ret =3D xen_9pfs_front_alloc_dataring(dev, &priv->rings[i],
>  						    max_ring_order);
> @@ -434,10 +434,11 @@ static int xen_9pfs_front_init(struct xenbus_device=
 *dev)
>  	if (ret)
>  		goto error_xenbus;
>  	ret =3D xenbus_printf(xbt, dev->nodename, "num-rings", "%u",
> -			    priv->num_rings);
> +			    num_rings);
>  	if (ret)
>  		goto error_xenbus;
> -	for (i =3D 0; i < priv->num_rings; i++) {
> +
> +	for (i =3D 0; i < num_rings; i++) {
>  		char str[16];
> =20
>  		BUILD_BUG_ON(XEN_9PFS_NUM_RINGS > 9);
>=20




