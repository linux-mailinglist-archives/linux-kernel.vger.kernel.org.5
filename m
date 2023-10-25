Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B757D723D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjJYRYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJYRYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:24:31 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB5712F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=FlP2OX/+ZKnAFnDt16QpAd64LCWgb2UENfUNdPcSJLY=; b=gaAUYGh+tdpK58mXV/d2/2AN7s
        VfpabAYs/w9lIbElinhIeGWd9iWNVoeS5bBuRGBqrrQhgqA/0GQF65VO0HOaWE3WIN+DCpshDyxVR
        X55O5cKOPQitk3o6dZXvDeF8cH28yMJVink6YCTzFT9NNHqlar3zeOG5VDCZOO944NxWdh6qV//hl
        ISQntYamm2a929En31PtnLYqN+XncFSju7L54zTE+tzqWQUA9BsZylmdVrJccLJnSYJoRbMzbYQTE
        tNinlXSPR5HAVgNOdYk8frUsn00PmwETKc+gjksUc6mpImdMhH4g8qPxifwSWAGCl8elzp7qUKXpS
        g2j16oU/F1eC3hI8QsRuZJh4vZ8/rNvsQ82jZWCuWG7awQfPlDhF6e63yl7CNOFBlRV3NyKf5ir5X
        P3xwaH8oRyBOgP+lNkERDSKNlCoyJSHa3Wd3DnPwqZ2IOYDqYmRut7ZrREnbvz5eKIo743Hne/jJm
        MIAqf60ytaHcatnW2Eswow9dYCuHnVoCLpLJZdCokntN5+V/ALR//GIhkj02R3AaK8GT3o9Hi2Oy5
        jTPkpXVeQZuXoU8AP5/ovVOvc840QBg3E/Zki32l6jmJbf+0wPio7fEwudqjyozn8TvBsKU/EN/Ji
        FuDCYnMawsRZsj726qP+8VBpYaofu5IzNzxfrql2I=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     v9fs@lists.linux.dev, Dominique Martinet <asmadeus@codewreck.org>
Cc:     ericvh@kernel.org, lucho@ionkov.net, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH v2 3/3] 9p/net: xen: fix false positive printf format overflow
 warning
Date:   Wed, 25 Oct 2023 19:24:11 +0200
Message-ID: <1940104.uIXT7tB08N@silver>
In-Reply-To: <20231025103445.1248103-3-asmadeus@codewreck.org>
References: <20231025103445.1248103-1-asmadeus@codewreck.org>
 <20231025103445.1248103-3-asmadeus@codewreck.org>
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

On Wednesday, October 25, 2023 12:34:45 PM CEST Dominique Martinet wrote:
> Use the constant to make the compiler happy about this warning:
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
> values for 'i' here, using the constant directly here makes it work.
>=20
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> Message-ID: <20231023233704.1185154-4-asmadeus@codewreck.org>
> ---

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> v1->v2:
> - use constant directly instead of going through a local variable
>=20
>  net/9p/trans_xen.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
> index 1fffe2bed5b0..dfdbe1ca5338 100644
> --- a/net/9p/trans_xen.c
> +++ b/net/9p/trans_xen.c
> @@ -54,7 +54,6 @@ struct xen_9pfs_front_priv {
>  	char *tag;
>  	struct p9_client *client;
> =20
> -	int num_rings;
>  	struct xen_9pfs_dataring *rings;
>  };
> =20
> @@ -131,7 +130,7 @@ static int p9_xen_request(struct p9_client *client, s=
truct p9_req_t *p9_req)
>  	if (list_entry_is_head(priv, &xen_9pfs_devs, list))
>  		return -EINVAL;
> =20
> -	num =3D p9_req->tc.tag % priv->num_rings;
> +	num =3D p9_req->tc.tag % XEN_9PFS_NUM_RINGS;
>  	ring =3D &priv->rings[num];
> =20
>  again:
> @@ -279,7 +278,7 @@ static void xen_9pfs_front_free(struct xen_9pfs_front=
_priv *priv)
>  	list_del(&priv->list);
>  	write_unlock(&xen_9pfs_lock);
> =20
> -	for (i =3D 0; i < priv->num_rings; i++) {
> +	for (i =3D 0; i < XEN_9PFS_NUM_RINGS; i++) {
>  		struct xen_9pfs_dataring *ring =3D &priv->rings[i];
> =20
>  		cancel_work_sync(&ring->work);
> @@ -408,15 +407,14 @@ static int xen_9pfs_front_init(struct xenbus_device=
 *dev)
>  	if (p9_xen_trans.maxsize > XEN_FLEX_RING_SIZE(max_ring_order))
>  		p9_xen_trans.maxsize =3D XEN_FLEX_RING_SIZE(max_ring_order) / 2;
> =20
> -	priv->num_rings =3D XEN_9PFS_NUM_RINGS;
> -	priv->rings =3D kcalloc(priv->num_rings, sizeof(*priv->rings),
> +	priv->rings =3D kcalloc(XEN_9PFS_NUM_RINGS, sizeof(*priv->rings),
>  			      GFP_KERNEL);
>  	if (!priv->rings) {
>  		kfree(priv);
>  		return -ENOMEM;
>  	}
> =20
> -	for (i =3D 0; i < priv->num_rings; i++) {
> +	for (i =3D 0; i < XEN_9PFS_NUM_RINGS; i++) {
>  		priv->rings[i].priv =3D priv;
>  		ret =3D xen_9pfs_front_alloc_dataring(dev, &priv->rings[i],
>  						    max_ring_order);
> @@ -434,10 +432,11 @@ static int xen_9pfs_front_init(struct xenbus_device=
 *dev)
>  	if (ret)
>  		goto error_xenbus;
>  	ret =3D xenbus_printf(xbt, dev->nodename, "num-rings", "%u",
> -			    priv->num_rings);
> +			    XEN_9PFS_NUM_RINGS);
>  	if (ret)
>  		goto error_xenbus;
> -	for (i =3D 0; i < priv->num_rings; i++) {
> +
> +	for (i =3D 0; i < XEN_9PFS_NUM_RINGS; i++) {
>  		char str[16];
> =20
>  		BUILD_BUG_ON(XEN_9PFS_NUM_RINGS > 9);
>=20




