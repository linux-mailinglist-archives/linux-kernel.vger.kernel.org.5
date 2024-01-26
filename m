Return-Path: <linux-kernel+bounces-39794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F88283D62D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944061C26F37
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56061EB2B;
	Fri, 26 Jan 2024 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3FZBtAf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD1B1EA76
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259093; cv=none; b=LVXQ7uKY0ncI7Baa1jpdq32r1DS9PtNBaq3Bkja50d4qm6sYGBqsxZAsS6zbLx0aqyWLqFDJyhDOt6Hh0A82pP0VCNbKaZx1RKWzdllvBQwNwqF23I2+5QkSkZLV56pYtDPwClKiNxxA1lJ6XpVSvg7CEyJ+ovPjcZPoYmzw1mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259093; c=relaxed/simple;
	bh=pprwQeE7XcdoVLzqAGFTtrwLSXJiUSUwBVQMMXGwiaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMluEjXOT3EXhO+ZtCAp61JWBAyca4XKdnL0UeD9XYWUa9ezuz+wJ51LRIjb50VxmJUmf84jpDjrDyuYT3M1t7MxTOAC55NJdQcgKj4qeULf81JnWPdfJGQMxe42TMR0xy7pCSAkrgAm6h5/eNrp77A8/TE16MSuNax3dYLA5x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3FZBtAf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706259090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5KKf6EWmgBy5sHid0BIM6PUxOBJIEnPe2IydxsmIfcw=;
	b=f3FZBtAfyGFONONQd0BfzDRlSa210DHa3ctZ5W2NaxOa9/drVgTcztrrfZCDfM66EudexA
	SJ08tHkjKJAss98XrYFRHA4jVEuEvb4HEeAIov1zKl7Ysj+nqSkfhfBI+49A35bLhuKLiF
	VmI2wYV3PMlxQylgOmQiRgKn3T+wztY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-Oene1Fx_M6OXKLJ6f2-ZIQ-1; Fri, 26 Jan 2024 03:51:28 -0500
X-MC-Unique: Oene1Fx_M6OXKLJ6f2-ZIQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a2f71c9f5d2so5257166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:51:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706259087; x=1706863887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KKf6EWmgBy5sHid0BIM6PUxOBJIEnPe2IydxsmIfcw=;
        b=kFhFpMnyrfiNMNLj2IRxFoVb5U7NdDTvU9OGM94xRYpLLB/tOWl3d8TFYq9xqxeJdk
         SKDpnGhxRtZrQYbDjnqARlTRJDuxOOQwPvpbOgAdPKF1HsFMQBG8bjxObBV8qJ8HAEON
         RR0QtErjJjOjpFAdo8BNjliSajpvHywlvtCCOqgl1WSd+2mP4ovgOyRP0JLnZwjF0EjW
         Th/sK5CZZDAb29gj/IKD2cYeMHretf8Spk8IWinPV/XMRYPgCvO1tWbpXBU5X13Gha6s
         1o9tBcp8qd5fcgQTb788Bm+wgExukfE8/ks0non9ohiGaFFHYlGgwwRIi1SKkSNSdRsX
         1C2g==
X-Gm-Message-State: AOJu0YxlDLnQ20o3v7veMSOK5MYghImRqCs0aVgUyIhUvgNg7jqdFK8F
	fgpSg8x7LuFZKrz6s5gpAgPRaUqV51fqFG4DmoOUJ2KndB0oLmPl/eeWLsaD/ut6qY9n9BBaj11
	6S/wk8TBKNQ0g4RIMLAh+gcrYVImugfjIR3MDdPvg3F2dGN9MDcArx9ylLuPRti1uSy5h6Ox3pK
	0ZHcZ2D0rQ0/Mlnai71w0iu+17g3BWITfjTdZ0
X-Received: by 2002:a17:906:d7ac:b0:a2f:1575:c80c with SMTP id pk12-20020a170906d7ac00b00a2f1575c80cmr490112ejb.7.1706259087571;
        Fri, 26 Jan 2024 00:51:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9oo/LCRdvPJXxxBEwEoCRvH/zKsQWc51yiYv/+/06+IKO9WHrS3EsnECmxKCM2YJvHB/svoV5vEpSf8kt7aU=
X-Received: by 2002:a17:906:d7ac:b0:a2f:1575:c80c with SMTP id
 pk12-20020a170906d7ac00b00a2f1575c80cmr490099ejb.7.1706259087196; Fri, 26 Jan
 2024 00:51:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7258a4cc-da16-5c34-a042-2a23ee396d56@redhat.com> <IA0PR11MB7185B400DD4A4FD65FD51437F87B2@IA0PR11MB7185.namprd11.prod.outlook.com>
In-Reply-To: <IA0PR11MB7185B400DD4A4FD65FD51437F87B2@IA0PR11MB7185.namprd11.prod.outlook.com>
From: Zhenyu Zhang <zhenyzha@redhat.com>
Date: Fri, 26 Jan 2024 16:50:50 +0800
Message-ID: <CAJFLiBJ5K_WbiNmrgaKD9_UAs4HQRv_xGyQcwBy6a9XusUTeew@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/virtio: set segment size for virtio_gpu device
To: Sebastian Ott <seott@redhat.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, 
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[PATCH RESEND] drm/virtio: set segment size for virtio_gpu device

Test on 64k basic page size aarch64(6.8.0-rc1-zhenyzha+)
During the boot process, the call trace no longer appears.
The test results are as expected.

Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>

On Thu, Jan 25, 2024 at 5:24=E2=80=AFAM Kasireddy, Vivek
<vivek.kasireddy@intel.com> wrote:
>
> > Hej,
> >
> > debug dma code is not happy with virtio gpu (arm64 VM):
> >
> > [  305.881733] ------------[ cut here ]------------
> > [  305.883117] DMA-API: virtio-pci 0000:07:00.0: mapping sg segment lon=
ger
> > than device claims to support [len=3D262144] [max=3D65536]
> > [  305.885976] WARNING: CPU: 8 PID: 2002 at kernel/dma/debug.c:1177
> > check_sg_segment+0x2d0/0x420
> > [  305.888038] Modules linked in: crct10dif_ce(+) polyval_ce polyval_ge=
neric
> > ghash_ce virtio_gpu(+) virtio_net net_failover virtio_blk(+) virtio_dma=
_buf
> > virtio_console failover virtio_mmio scsi_dh_r dac scsi_dh_emc scsi_dh_a=
lua
> > dm_multipath qemu_fw_cfg
> > [  305.893496] CPU: 8 PID: 2002 Comm: (udev-worker) Not tainted 6.7.0 #=
1
> > [  305.895070] Hardware name: QEMU KVM Virtual Machine, BIOS edk2-
> > 20230524-3.fc37 05/24/2023
> > [  305.897112] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
> > BTYPE=3D--)
> > [  305.897129] pc : check_sg_segment+0x2d0/0x420
> > [  305.897139] lr : check_sg_segment+0x2d0/0x420
> > [  305.897145] sp : ffff80008ffc69d0
> > [  305.897149] x29: ffff80008ffc69d0 x28: dfff800000000000 x27:
> > ffffb0232879e578
> > [  305.897167] x26: ffffffff00000000 x25: ffffb0232778c060 x24:
> > ffff19ee9b2060c0
> > [  305.897181] x23: 00000000ffffffff x22: ffffb0232ab9ce10 x21:
> > ffff19eece5c64ac
> > [  305.906942] x20: 0000000000010000 x19: ffff19eece5c64a0 x18:
> > ffff19eec36fc304
> > [  305.908633] x17: 6e61687420726567 x16: 6e6f6c20746e656d x15:
> > 6765732067732067
> > [  305.910352] x14: 00000000f1f1f1f1 x13: 0000000000000001 x12:
> > ffff700011ff8cc3
> > [  305.912044] x11: 1ffff00011ff8cc2 x10: ffff700011ff8cc2 x9 :
> > ffffb02324a70e54
> > [  305.913751] x8 : 00008fffee00733e x7 : ffff80008ffc6617 x6 :
> > 0000000000000001
> > [  305.915451] x5 : ffff80008ffc6610 x4 : 1fffe33e70564622 x3 :
> > dfff800000000000
> > [  305.917158] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
> > ffff19f382b23100
> > [  305.918864] Call trace:
> > [  305.919474]  check_sg_segment+0x2d0/0x420
> > [  305.920443]  debug_dma_map_sg+0x2a0/0x428
> > [  305.921402]  __dma_map_sg_attrs+0xf4/0x1a8
> > [  305.922388]  dma_map_sgtable+0x7c/0x100
> > [  305.923318]  drm_gem_shmem_get_pages_sgt+0x15c/0x328
> > [  305.924500]
> > virtio_gpu_object_shmem_init.constprop.0.isra.0+0x50/0x628 [virtio_gpu]
> > [  305.926390]  virtio_gpu_object_create+0x198/0x478 [virtio_gpu]
> > [  305.927802]  virtio_gpu_mode_dumb_create+0x2a0/0x4c8 [virtio_gpu]
> > [  305.929272]  drm_mode_create_dumb+0x1c0/0x280
> > [  305.930327]  drm_client_framebuffer_create+0x140/0x328
> > [  305.931555]  drm_fbdev_generic_helper_fb_probe+0x1bc/0x5c0
> > [  305.932871]  __drm_fb_helper_initial_config_and_unlock+0x1e0/0x630
> > [  305.934372]  drm_fb_helper_initial_config+0x50/0x68
> > [  305.935540]  drm_fbdev_generic_client_hotplug+0x148/0x200
> > [  305.936819]  drm_client_register+0x130/0x200
> > [  305.937856]  drm_fbdev_generic_setup+0xe8/0x320
> > [  305.938932]  virtio_gpu_probe+0x13c/0x2d0 [virtio_gpu]
> > [  305.940190]  virtio_dev_probe+0x38c/0x600
> > [  305.941153]  really_probe+0x334/0x9c8
> > [  305.942047]  __driver_probe_device+0x164/0x3d8
> > [  305.943102]  driver_probe_device+0x64/0x180
> > [  305.944094]  __driver_attach+0x1d4/0x488
> > [  305.945045]  bus_for_each_dev+0x104/0x198
> > [  305.946008]  driver_attach+0x44/0x68
> > [  305.946892]  bus_add_driver+0x23c/0x4a8
> > [  305.947838]  driver_register+0xf8/0x3d0
> > [  305.948770]  register_virtio_driver+0x74/0xc8
> > [  305.949836]  virtio_gpu_driver_init+0x20/0xff8 [virtio_gpu]
> > [  305.951237]  do_one_initcall+0x17c/0x8c0
> > [  305.952182]  do_init_module+0x1dc/0x630
> > [  305.953106]  load_module+0x10c0/0x1638
> > [  305.954012]  init_module_from_file+0xe0/0x140
> > [  305.955058]  idempotent_init_module+0x2c0/0x590
> > [  305.956174]  __arm64_sys_finit_module+0xb4/0x140
> > [  305.957282]  invoke_syscall+0xd8/0x258
> > [  305.958187]  el0_svc_common.constprop.0+0x16c/0x240
> > [  305.959526]  do_el0_svc+0x48/0x68
> > [  305.960456]  el0_svc+0x58/0x118
> > [  305.961310]  el0t_64_sync_handler+0x120/0x130
> > [  305.962510]  el0t_64_sync+0x194/0x198
> > [  305.963509] irq event stamp: 37944
> > [  305.964412] hardirqs last  enabled at (37943): [<ffffb02324a7439c>]
> > console_unlock+0x1a4/0x1c8
> > [  305.966602] hardirqs last disabled at (37944): [<ffffb023276724e4>]
> > el1_dbg+0x24/0xa0
> > [  305.968535] softirqs last  enabled at (37930): [<ffffb0232475114c>]
> > __do_softirq+0x8e4/0xe1c
> > [  305.970781] softirqs last disabled at (37925): [<ffffb0232475a9b0>]
> > ____do_softirq+0x18/0x30
> > [  305.972937] ---[ end trace 0000000000000000 ]---
> >
> > The 64K max_segment size of the device seems to be inherited by PCIs
> > default.
> > The sg list is crated via this drm helper:
> >
> > struct sg_table *drm_prime_pages_to_sg(struct drm_device *dev,
> >                                      struct page **pages, unsigned int
> > nr_pages)
> > {
> > ...
> >       if (dev)
> >               max_segment =3D dma_max_mapping_size(dev->dev);
> >       if (max_segment =3D=3D 0)
> >               max_segment =3D UINT_MAX;
> >       err =3D sg_alloc_table_from_pages_segment(sg, pages, nr_pages, 0,
> >                                               nr_pages << PAGE_SHIFT,
> >                                               max_segment, GFP_KERNEL);
> > ...
> > }
> >
> > I'm a bit puzzled why this uses dma_max_mapping_size() and not
> > dma_get_max_seg_size(). But since this is used by a lot of drivers
> > I'm not really keen to touch this code that works like this for ages.
> >
> > So let's just make debug dma code aware of the actual segment size
> > that's used by the device:
> >
> > --->8
> > drm/virtio: set segment size for virtio_gpu device
> >
> > Set the segment size of the virtio_gpu device to the value
> > used by the drm helpers when allocating sg lists to fix the
> > following complaint from DMA_API debug code:
> > DMA-API: virtio-pci 0000:07:00.0: mapping sg segment longer than device
> > claims to support [len=3D262144] [max=3D65536]
> >
> > Signed-off-by: Sebastian Ott <sebott@redhat.com>
> > ---
> >    drivers/gpu/drm/virtio/virtgpu_drv.c | 1 +
> >    1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c
> > b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > index 4334c7608408..74b2cb3295af 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > @@ -94,6 +94,7 @@ static int virtio_gpu_probe(struct virtio_device *vde=
v)
> >                       goto err_free;
> >       }
> >
> > +     dma_set_max_seg_size(dev->dev, dma_max_mapping_size(dev-
> > >dev) ? : UINT_MAX);
> Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>
> >       ret =3D virtio_gpu_init(vdev, dev);
> >       if (ret)
> >               goto err_free;
> > --
> > 2.43.0
> >
> >
>
>


