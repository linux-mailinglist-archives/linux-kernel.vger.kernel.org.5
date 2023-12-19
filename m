Return-Path: <linux-kernel+bounces-6040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D593819375
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058EC285A98
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B2C3D0B3;
	Tue, 19 Dec 2023 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="adyFdn8b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2EE3D0A2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703024654;
	bh=CgrpkyE49e//9hUaNjaVNDoFSnfuyCR13nS2KC7yqY0=;
	h=Date:From:Cc:Subject:From;
	b=adyFdn8bPtrgPxJ9JVZ+fD7mt7gvImxcc2sQxwIovlJJCrtJTB5FRh9mckht+QakM
	 rLuFio3TNutKjpSFM9tx5kvErgqcBfv5TCvuMspPrmVpGKgP35eWgYkHKmMX9VJJYC
	 MYQqAKhgHWoxEBX5RNZeHfR4n1KLDB3IYUCIfId5wjjOmy7rvT4f3Q3oT4+xSsaud0
	 kBd0jn8XioUsLx/ZgUEMmjgWghmYNcrMCCatTPkZ5V5+YOi/tVBgO7VUAKv6e1R9r/
	 /X/AVcqB8TY+8m4QBAlM8qbED35o9/Ogcn7+KjskhTjI48XsSHI+mby+wxlR/G/ANU
	 z9lNXGeFsrnUQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 6447E13964;
	Tue, 19 Dec 2023 23:24:14 +0100 (CET)
Date: Tue, 19 Dec 2023 23:24:14 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foudation.org>, 
	Li kunyu <kunyu@nfschina.com>, Zhao Lei <zhao_lei1@hoperun.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Zhang Zhengming <zhang.zhengming@h3c.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: relay: remove =?utf-8?Q?relay=5Ffile=5Fsplice=5Fr?=
 =?utf-8?B?ZWFkIOKAkg==?= dead code, doesn't work
Message-ID: <dtexwpw6zcdx7dkx3xj5gyjp5syxmyretdcbcdtvrnukd4vvuh@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q64o4f6ck35bgcf2"
Content-Disposition: inline
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--q64o4f6ck35bgcf2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Documentation/filesystems/relay.rst says to use
	return debugfs_create_file(filename, mode, parent, buf,
	                           &relay_file_operations);
and this is the only way relay_file_operations is used.

Thus: debugfs_create_file(&relay_file_operations)
   -> __debugfs_create_file(&debugfs_full_proxy_file_operations,
                            &relay_file_operations)
   -> dentry{inode: {i_fop: &debugfs_full_proxy_file_operations},
             d_fsdata: &relay_file_operations
                       | DEBUGFS_FSDATA_IS_REAL_FOPS_BIT}

debugfs_full_proxy_file_operations.open is full_proxy_open, which
extracts the &relay_file_operations from the dentry, and allocates
via __full_proxy_fops_init() new fops, with trivial wrappers around
release, llseek, read, write, poll, and unlocked_ioctl, then replaces
the fops on the opened file therewith.

Naturally, all thusly-created debugfs files have .splice_read =3D NULL.
This was introduced in
commit 49d200deaa680501f19a247b1fffb29301e51d2b ("debugfs: prevent
 access to removed files' private data") from 2016-03-22.

AFAICT, relay_file_operations is the only struct file_operations
used for debugfs which defines a .splice_read callback.
Hooking it up with
>	diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
>	index 5063434be0fc..952fcf5b2afa 100644
>	--- a/fs/debugfs/file.c
>	+++ b/fs/debugfs/file.c
>	@@ -328,6 +328,11 @@ FULL_PROXY_FUNC(write, ssize_t, filp,
>	 			loff_t *ppos),
>	 		ARGS(filp, buf, size, ppos));
>
>	+FULL_PROXY_FUNC(splice_read, long, in,
>	+		PROTO(struct file *in, loff_t *ppos, struct pipe_inode_info *pipe,
>	+			size_t len, unsigned int flags),
>	+		ARGS(in, ppos, pipe, len, flags));
>	+
>	 FULL_PROXY_FUNC(unlocked_ioctl, long, filp,
>	 		PROTO(struct file *filp, unsigned int cmd, unsigned long arg),
>	 		ARGS(filp, cmd, arg));
>	@@ -382,6 +387,8 @@ static void __full_proxy_fops_init(struct file_operat=
ions *proxy_fops,
>	 		proxy_fops->write =3D full_proxy_write;
>	 	if (real_fops->poll)
>	 		proxy_fops->poll =3D full_proxy_poll;
>	+	if (real_fops->splice_read)
>	+		proxy_fops->splice_read =3D full_proxy_splice_read;
>	 	if (real_fops->unlocked_ioctl)
>	 		proxy_fops->unlocked_ioctl =3D full_proxy_unlocked_ioctl;
>	 }
shows it just doesn't work, and splicing always instantly returns empty
(subsequent reads actually return the contents).

No-one noticed it became dead code in 2016, who knows if it worked back
then. Clearly no-one cares; just delete it.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 kernel/relay.c | 162 -------------------------------------------------
 1 file changed, 162 deletions(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index 83fe0325cde1..a8e90e98bf2c 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -1073,167 +1073,6 @@ static ssize_t relay_file_read(struct file *filp,
 	return written;
 }
=20
-static void relay_consume_bytes(struct rchan_buf *rbuf, int bytes_consumed)
-{
-	rbuf->bytes_consumed +=3D bytes_consumed;
-
-	if (rbuf->bytes_consumed >=3D rbuf->chan->subbuf_size) {
-		relay_subbufs_consumed(rbuf->chan, rbuf->cpu, 1);
-		rbuf->bytes_consumed %=3D rbuf->chan->subbuf_size;
-	}
-}
-
-static void relay_pipe_buf_release(struct pipe_inode_info *pipe,
-				   struct pipe_buffer *buf)
-{
-	struct rchan_buf *rbuf;
-
-	rbuf =3D (struct rchan_buf *)page_private(buf->page);
-	relay_consume_bytes(rbuf, buf->private);
-}
-
-static const struct pipe_buf_operations relay_pipe_buf_ops =3D {
-	.release	=3D relay_pipe_buf_release,
-	.try_steal	=3D generic_pipe_buf_try_steal,
-	.get		=3D generic_pipe_buf_get,
-};
-
-static void relay_page_release(struct splice_pipe_desc *spd, unsigned int =
i)
-{
-}
-
-/*
- *	subbuf_splice_actor - splice up to one subbuf's worth of data
- */
-static ssize_t subbuf_splice_actor(struct file *in,
-			       loff_t *ppos,
-			       struct pipe_inode_info *pipe,
-			       size_t len,
-			       unsigned int flags,
-			       int *nonpad_ret)
-{
-	unsigned int pidx, poff, total_len, subbuf_pages, nr_pages;
-	struct rchan_buf *rbuf =3D in->private_data;
-	unsigned int subbuf_size =3D rbuf->chan->subbuf_size;
-	uint64_t pos =3D (uint64_t) *ppos;
-	uint32_t alloc_size =3D (uint32_t) rbuf->chan->alloc_size;
-	size_t read_start =3D (size_t) do_div(pos, alloc_size);
-	size_t read_subbuf =3D read_start / subbuf_size;
-	size_t padding =3D rbuf->padding[read_subbuf];
-	size_t nonpad_end =3D read_subbuf * subbuf_size + subbuf_size - padding;
-	struct page *pages[PIPE_DEF_BUFFERS];
-	struct partial_page partial[PIPE_DEF_BUFFERS];
-	struct splice_pipe_desc spd =3D {
-		.pages =3D pages,
-		.nr_pages =3D 0,
-		.nr_pages_max =3D PIPE_DEF_BUFFERS,
-		.partial =3D partial,
-		.ops =3D &relay_pipe_buf_ops,
-		.spd_release =3D relay_page_release,
-	};
-	ssize_t ret;
-
-	if (rbuf->subbufs_produced =3D=3D rbuf->subbufs_consumed)
-		return 0;
-	if (splice_grow_spd(pipe, &spd))
-		return -ENOMEM;
-
-	/*
-	 * Adjust read len, if longer than what is available
-	 */
-	if (len > (subbuf_size - read_start % subbuf_size))
-		len =3D subbuf_size - read_start % subbuf_size;
-
-	subbuf_pages =3D rbuf->chan->alloc_size >> PAGE_SHIFT;
-	pidx =3D (read_start / PAGE_SIZE) % subbuf_pages;
-	poff =3D read_start & ~PAGE_MASK;
-	nr_pages =3D min_t(unsigned int, subbuf_pages, spd.nr_pages_max);
-
-	for (total_len =3D 0; spd.nr_pages < nr_pages; spd.nr_pages++) {
-		unsigned int this_len, this_end, private;
-		unsigned int cur_pos =3D read_start + total_len;
-
-		if (!len)
-			break;
-
-		this_len =3D min_t(unsigned long, len, PAGE_SIZE - poff);
-		private =3D this_len;
-
-		spd.pages[spd.nr_pages] =3D rbuf->page_array[pidx];
-		spd.partial[spd.nr_pages].offset =3D poff;
-
-		this_end =3D cur_pos + this_len;
-		if (this_end >=3D nonpad_end) {
-			this_len =3D nonpad_end - cur_pos;
-			private =3D this_len + padding;
-		}
-		spd.partial[spd.nr_pages].len =3D this_len;
-		spd.partial[spd.nr_pages].private =3D private;
-
-		len -=3D this_len;
-		total_len +=3D this_len;
-		poff =3D 0;
-		pidx =3D (pidx + 1) % subbuf_pages;
-
-		if (this_end >=3D nonpad_end) {
-			spd.nr_pages++;
-			break;
-		}
-	}
-
-	ret =3D 0;
-	if (!spd.nr_pages)
-		goto out;
-
-	ret =3D *nonpad_ret =3D splice_to_pipe(pipe, &spd);
-	if (ret < 0 || ret < total_len)
-		goto out;
-
-        if (read_start + ret =3D=3D nonpad_end)
-                ret +=3D padding;
-
-out:
-	splice_shrink_spd(&spd);
-	return ret;
-}
-
-static ssize_t relay_file_splice_read(struct file *in,
-				      loff_t *ppos,
-				      struct pipe_inode_info *pipe,
-				      size_t len,
-				      unsigned int flags)
-{
-	ssize_t spliced;
-	int ret;
-	int nonpad_ret =3D 0;
-
-	ret =3D 0;
-	spliced =3D 0;
-
-	while (len && !spliced) {
-		ret =3D subbuf_splice_actor(in, ppos, pipe, len, flags, &nonpad_ret);
-		if (ret < 0)
-			break;
-		else if (!ret) {
-			if (flags & SPLICE_F_NONBLOCK)
-				ret =3D -EAGAIN;
-			break;
-		}
-
-		*ppos +=3D ret;
-		if (ret > len)
-			len =3D 0;
-		else
-			len -=3D ret;
-		spliced +=3D nonpad_ret;
-		nonpad_ret =3D 0;
-	}
-
-	if (spliced)
-		return spliced;
-
-	return ret;
-}
=20
 const struct file_operations relay_file_operations =3D {
 	.open		=3D relay_file_open,
@@ -1242,6 +1081,5 @@ const struct file_operations relay_file_operations =
=3D {
 	.read		=3D relay_file_read,
 	.llseek		=3D no_llseek,
 	.release	=3D relay_file_release,
-	.splice_read	=3D relay_file_splice_read,
 };
 EXPORT_SYMBOL_GPL(relay_file_operations);
--=20
2.39.2

--q64o4f6ck35bgcf2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWCGA0ACgkQvP0LAY0m
WPF2AA//SDllAbJh5sHw/XB+9V05ssQxhfvG9P8O1ew5toxr3/d6HyqZkjq4T7VR
F1nbCbI0QejBxBs9v5weKEoSkocIrR6rON8fLuaeLm9xAxzZfq7MB1HF9DJtVrsu
EyfqtIrxobcHrESYkvYUTkUf+0JUwq+8nC94ZjSlzESM7AQJDKPumdST+wa4T4na
rREC8wZMDdU+j75TZvTJ8ORacBsnjgam0gPiw/fynk7XM7wikN7m5nZCk559hgo1
dik2TIDfOhW7thnvHSe83T9cJQY/BZqKn0XmBLeqalietLfizLaMJjHOcyQ6JJJN
QrD0Rg+nzniFOR0kpEDm6vxOQWNnL4ouefcZz9LRGpvQB52MKLwGrFc2DZRSzIjT
aI1dqqulMuihHGcRKHJ9HIgQxrBCyrz2kYPWA+YenfShUqgII5/n8dGe5Mn9FhOm
GNO1YHmzQlooevsxlPLACIz/6sEFXPUGyLyJ9iZefqSNIq3Kw2yTvnlhLS/rQqQC
DJVMORuxovaBEl2jEzmtEN3qdnjQwh4tP05FpmhK1zPaiVZOT7PhMZ3116o8AV3c
ckYO4iYp5I7aMRbuJ82trFq4f0OoHnE4I00ki/FJJNITVI00k9KUPmYVuDnUAa2e
3kxoozVDtTlo56wWbm1n4yQ9r34iI+Jm36jeeUxOALc2g1CKS78=
=mBlW
-----END PGP SIGNATURE-----

--q64o4f6ck35bgcf2--

