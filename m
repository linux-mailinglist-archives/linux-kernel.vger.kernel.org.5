Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C272C7AF723
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 02:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjI0AN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 20:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjI0ALz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 20:11:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49FC46A3;
        Tue, 26 Sep 2023 16:29:56 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [45.84.211.191])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 17FCD660731C;
        Wed, 27 Sep 2023 00:29:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695770995;
        bh=KvkFiRPKdGvQj6Wwi6VvHejV7MQfknC6iOfkSZ6pmlE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LfBmxNENe/eR4pJ9lyOCjRMq+x7WuYXFbiKxTml38dPsrQMEqFaRtzEgGD1s5IhSH
         zXbf9W95YsRig7QHa2BGwVCKm76pJRZn1BGfSejxlwDB4dmUgTWObJtzTXPFL6t4ZW
         Trm8y9COhly+XRF/Vc4As0ZwgChdRFKOQ4gY2y3d/6a/5bCQzGIilz1kTK+a8t5NnY
         0+QmMv9WdcnPWk81BQ4afIn377rIlDTcbQWAL/ORHTd8y3zdNGYmM7dEK7GOtcc606
         Q9gzulHTxZfnOq+zD4suirgrC8DKRoWgU9ZCmEsidiCG1OSvWYQGydEnJNJ/+p4jw3
         7wi79sNdbBYJw==
Message-ID: <330a177320fd766af8eddb76f57ea728b2e36afe.camel@collabora.com>
Subject: Re: [PATCH v12 5/7] media: chips-media: wave5: Add the v4l2 layer
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robert Beckett <bob.beckett@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Date:   Wed, 27 Sep 2023 01:29:44 +0200
In-Reply-To: <6ae8a639-b9f5-4426-be49-5340a8b8b5e9@xs4all.nl>
References: <20230915-wave5_v12_on_media_master-v12-0-92fc66cd685d@collabora.com>
         <20230915-wave5_v12_on_media_master-v12-5-92fc66cd685d@collabora.com>
         <b7aa9a5a-018a-4d78-b001-4ba84acb1e24@xs4all.nl>
         <7b159731dfbc2ab8243396eaec8f41be10af5160.camel@collabora.com>
         <6ae8a639-b9f5-4426-be49-5340a8b8b5e9@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 22 septembre 2023 =C3=A0 09:33 +0200, Hans Verkuil a =C3=A9crit=
=C2=A0:
> On 21/09/2023 21:11, Nicolas Dufresne wrote:
> > Le mercredi 20 septembre 2023 =C3=A0 17:13 +0200, Hans Verkuil a =C3=A9=
crit=C2=A0:
> > > On 15/09/2023 23:11, Sebastian Fricke wrote:
> > > > From: Nas Chung <nas.chung@chipsnmedia.com>
> > > >=20
> > > > Add the decoder and encoder implementing the v4l2
> > > > API. This patch also adds the Makefile and the VIDEO_WAVE_VPU confi=
g
> > > >=20
> > > > Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> > > > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > > > Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> > > > Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> > > > Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> > > > ---
> > > >  drivers/media/platform/chips-media/Kconfig         |    1 +
> > > >  drivers/media/platform/chips-media/Makefile        |    1 +
> > > >  drivers/media/platform/chips-media/wave5/Kconfig   |   12 +
> > > >  drivers/media/platform/chips-media/wave5/Makefile  |   10 +
> > > >  .../platform/chips-media/wave5/wave5-helper.c      |  196 ++
> > > >  .../platform/chips-media/wave5/wave5-helper.h      |   30 +
> > > >  .../platform/chips-media/wave5/wave5-vpu-dec.c     | 1965 ++++++++=
++++++++++++
> > > >  .../platform/chips-media/wave5/wave5-vpu-enc.c     | 1825 ++++++++=
++++++++++
> > > >  .../media/platform/chips-media/wave5/wave5-vpu.c   |  331 ++++
> > > >  .../media/platform/chips-media/wave5/wave5-vpu.h   |   83 +
> > > >  10 files changed, 4454 insertions(+)
> > > >=20
>=20
> <snip>
>=20
> > > > +static int wave5_vpu_dec_set_eos_on_firmware(struct vpu_instance *=
inst)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	ret =3D wave5_vpu_dec_update_bitstream_buffer(inst, 0);
> > > > +	if (ret) {
> > > > +		dev_err(inst->dev->dev,
> > > > +			"Setting EOS for the bitstream, fail: %d\n", ret);
> > >=20
> > > Is this an error due to a driver problem, or because a bad bitstream =
is
> > > fed from userspace? In the first case, dev_err would be right, in the
> > > second dev_dbg would be more appropriate. Bad userspace input should =
not
> > > spam the kernel log in general.
> >=20
> > Its the first. To set the EOS flag, a command is sent to the firmware. =
That
> > command may never return (timeout) or may report an error. For this spe=
cific
> > command, if that happens we are likely facing firmware of driver proble=
m (or
> > both).
>=20
> OK, I'd add that as a comment here as this is unexpected behavior.
>=20
> >=20
> > >=20
> > > > +		return ret;
> > > > +	}
> > > > +	return 0;
> > > > +}
>=20
> <snip>
>=20
> > > > +static int wave5_vpu_dec_create_bufs(struct file *file, void *priv=
,
> > > > +				     struct v4l2_create_buffers *create)
> > > > +{
> > > > +	struct v4l2_format *f =3D &create->format;
> > > > +
> > > > +	if (f->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE)
> > > > +		return -ENOTTY;
> > >=20
> > > Huh? Why is this needed?
> >=20
> > Minimally a comment should be added. The why is that we support CREATE_=
BUF for
> > OUTPUT queue (bitstream) but not for CAPTURE queues. This is simply not
> > supported by Wave5 firmware. Do you have any suggestion how this asymme=
try can
> > be implemented better ?
>=20
> Certainly not with ENOTTY: the ioctl exists, it is just not supported for
> CAPTURE queues.
>=20
> How about -EPERM? And document this error as well in the VIDIOC_CREATE_BU=
FS
> documentation. And you want a dev_dbg here too.

The suggestion cannot be used since there is documentation for that one alr=
eady,
and it does not match "unsupported".

"Permission denied. Can be returned if the device needs write permission, o=
r
some special capabilities is needed (e. g. root)"

What about using the most logical error code, which name is actually obviou=
s,
like ENOTSUP ?

   #define ENOTSUPP	524	/* Operation is not supported */

>=20
> So I would propose that EPERM is returned if CREATE_BUFS is only supporte=
d
> for for one of the two queues of an M2M device.

Note that userspace does not care of the difference between an ioctl not be=
ing
implemented at all or not being implement for one queue. GStreamer have bee=
n
testing with both queue type for couple of years now. Adding this distincti=
on is
just leaking an implementation details to userspace. I'm fine to just do wh=
at
you'd like, just stating the obvious that while it may look logical inside =
the
kernel, its a bit of a non-sense for our users.

regards,
Nicolas

>=20
> >=20
> > >=20
> > > > +
> > > > +	return v4l2_m2m_ioctl_create_bufs(file, priv, create);
> > > > +}
>=20
> <snip>
>=20
> > > > +static int wave5_vpu_dec_queue_setup(struct vb2_queue *q, unsigned=
 int *num_buffers,
> > > > +				     unsigned int *num_planes, unsigned int sizes[],
> > > > +				     struct device *alloc_devs[])
> > > > +{
> > > > +	struct vpu_instance *inst =3D vb2_get_drv_priv(q);
> > > > +	struct v4l2_pix_format_mplane inst_format =3D
> > > > +		(q->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) ? inst->src_f=
mt : inst->dst_fmt;
> > > > +	unsigned int i;
> > > > +
> > > > +	dev_dbg(inst->dev->dev, "%s: num_buffers: %u | num_planes: %u | t=
ype: %u\n", __func__,
> > > > +		*num_buffers, *num_planes, q->type);
> > > > +
> > > > +	/* the CREATE_BUFS case */
> > > > +	if (*num_planes) {
> > > > +		if (inst_format.num_planes !=3D *num_planes)
> > > > +			return -EINVAL;
> > > > +
> > > > +		for (i =3D 0; i < *num_planes; i++) {
> > > > +			if (sizes[i] < inst_format.plane_fmt[i].sizeimage)
> > > > +				return -EINVAL;
> > > > +		}
> > > > +	/* the REQBUFS case */
> > > > +	} else {
> > > > +		*num_planes =3D inst_format.num_planes;
> > > > +
> > > > +		if (q->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
> > > > +			sizes[0] =3D inst_format.plane_fmt[0].sizeimage;
> > > > +			dev_dbg(inst->dev->dev, "%s: size[0]: %u\n", __func__, sizes[0]=
);
> > > > +		} else if (*num_planes =3D=3D 1) {
> > > > +			if (inst->output_format =3D=3D FORMAT_422)
> > > > +				sizes[0] =3D inst_format.width * inst_format.height * 2;
> > > > +			else
> > > > +				sizes[0] =3D inst_format.width * inst_format.height * 3 / 2;
> > > > +			dev_dbg(inst->dev->dev, "%s: size[0]: %u\n", __func__, sizes[0]=
);
> > > > +		} else if (*num_planes =3D=3D 2) {
> > > > +			sizes[0] =3D inst_format.width * inst_format.height;
> > > > +			if (inst->output_format =3D=3D FORMAT_422)
> > > > +				sizes[1] =3D inst_format.width * inst_format.height;
> > > > +			else
> > > > +				sizes[1] =3D inst_format.width * inst_format.height / 2;
> > > > +			dev_dbg(inst->dev->dev, "%s: size[0]: %u | size[1]: %u\n",
> > > > +				__func__, sizes[0], sizes[1]);
> > > > +		} else if (*num_planes =3D=3D 3) {
> > > > +			sizes[0] =3D inst_format.width * inst_format.height;
> > > > +			if (inst->output_format =3D=3D FORMAT_422) {
> > > > +				sizes[1] =3D inst_format.width * inst_format.height / 2;
> > > > +				sizes[2] =3D inst_format.width * inst_format.height / 2;
> > > > +			} else {
> > > > +				sizes[1] =3D inst_format.width * inst_format.height / 4;
> > > > +				sizes[2] =3D inst_format.width * inst_format.height / 4;
> > > > +			}
> > > > +			dev_dbg(inst->dev->dev, "%s: size[0]: %u | size[1]: %u | size[2=
]: %u\n",
> > > > +				__func__, sizes[0], sizes[1], sizes[2]);
> > > > +		}
> > > > +	}
> > > > +
> > > > +	if (inst->state =3D=3D VPU_INST_STATE_INIT_SEQ &&
> > > > +	    q->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
> > > > +		if (*num_buffers > inst->dst_buf_count &&
> > > > +		    *num_buffers < WAVE5_MAX_FBS)
> > > > +			inst->dst_buf_count =3D *num_buffers;
> > >=20
> > > In the create_bufs case, *num_buffers is the number of buffers you ar=
e
> > > adding to the already existing buffers. Frankly, the logic here is
> > > dubious. I'm not sure what the intent is. Why do you need to keep tra=
ck
> > > of the buf count at all when the vb2_queue already does that?
> >=20
> > This needs to be cleaned up. CREATE_BUFS case is not supported for capt=
ure, and
> > so there is no such weirdo case second calls for that queue at least. M=
eanwhile,
> > inst->dst_buf_count is used a MIN_BUFFERS_FOR_CAPTURE initially, and th=
e number
> > of allocated buffer later. I think it would be better to simply store t=
he min,
> > and use the queue to track the number of allocated buffers.
> >=20
> > In this diver, the reference frame are stored separately, and compresse=
d. The
> > capture queue contains the display frame. There is a gap when comes tim=
e to
> > transfer timestamp, and for this reason we had to keep the two fbc_coun=
t equal.
> > We classified this as hardware issue and moved on.
> >=20
> > I think the dst_buf_count can be dropped now and the "*num_buffers > in=
st-
> > > dst_buf_count" not longer make any sense.
> >=20
> > >=20
> > > WAVE5_MAX_FBS =3D=3D 32, which is VIDEO_MAX_FRAMES. You can just drop=
 the check
> > > against WAVE5_MAX_FBS since the core ensures already it will never al=
locate
> > > more than VIDEO_MAX_FRAMES.
> > >=20
> > > I'm not sure why WAVE5_MAX_FBS is defined at all, when it is just equ=
al to
> > > VIDEO_MAX_FRAMES. Perhaps it can be replaced everywhere with VIDEO_MA=
X_FRAMES?
> >=20
> > That is more challenging changes, since VIDEO_MAX_FRAMES is a software
> > limitation, but WAVE5_MAX_FBS is a hardware limitation. Buffer index on=
ly have 4
> > bits on this hardware. And the marking of frame being used for display =
is using
> > a 32bit flag. Considering there is effort to lift that software limitat=
ion, it
> > seems ill advised to completely stop ensuring this HW limit is respecte=
d.
>=20
> If there are only 4 bits for the buffer index, shouldn't WAVE5_MAX_FBS be=
 16? Or
> did you mean '5 bits'? Assuming that you meant '5 bits', then that makes
> WAVE5_MAX_FBS identical to VIDEO_MAX_FRAMES, but that is just luck, reall=
y.
>=20
> In any case, you should document at the place where WAVE5_MAX_FBS is defi=
ned that
> this is a hardware limitation, and not a random software limit.
>=20
> I also think that the DELETE_BUFS series should allow drivers to set max_=
num_buffers
> to a value less than 32 (currently the requirement is that it is at least=
 32).
>=20
> I saw a few more drivers that limit the number of buffers, usually based =
on the
> format (and so the buffer size) and some HW memory limitation. It might b=
e interesting
> to allow drivers to change max_num_buffers on the fly (provided no buffer=
s are
> allocated, of course). Limit checking is really something that vb2 should=
 do, and
> not the driver.
>=20
> >=20
> > I'm open for suggestions.
> >=20
> > >=20
> > > > +
> > > > +		*num_buffers =3D inst->dst_buf_count;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
>=20
> Regards,
>=20
> 	Hans

