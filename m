Return-Path: <linux-kernel+bounces-16031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518AC82373D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498D21C246B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B750B1DDF4;
	Wed,  3 Jan 2024 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="29AFP2b/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9BE1DDE2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704318173;
	bh=UDWldnzmwuhR1wrr9eaxOZpeEBaoD3KrQiTn/z2ISa4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=29AFP2b/4UB+1NRfxfgPk72jJaisg6OgdksozMENQ/jMI0bDAMIzAXJsUoonQwfyE
	 fRv0szC8+NM2/aFfbs3P8S3DU4Sv+yd77Kcvg8F7PweQbgbXx5Rzeru9eDxsRBN9hf
	 PoTrCUtDKBv/F7TitlqrsJACtuZ7ZBWxcLCV6qkIGQUzxWX9tIZu/vvpyrgguI4CYo
	 6uzDsZHFKEEvw5e5ZTM0F7Q9CWNYmZYO7VHIHkNdLoMH5/aLtrF/12ehie1q4oVWyd
	 yJggqMRLo0O4FnYCdrdU0zJvPvMVTqWWX06RR6AzrK+ncJvo6pIa1nV8+LH8y8HSxU
	 wTGj/D09kWCNw==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A4B0E37813CB;
	Wed,  3 Jan 2024 21:42:51 +0000 (UTC)
Message-ID: <de0381a6-2ad6-46a6-8d05-897799746456@collabora.com>
Date: Thu, 4 Jan 2024 00:42:48 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/virtio: Implement RESOURCE_GET_LAYOUT ioctl
Content-Language: en-US
To: Julia Zhang <julia.zhang@amd.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Daniel Stone <daniels@collabora.com>, Erik Faye-Lund <kusmabite@gmail.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20231221100016.4022353-1-julia.zhang@amd.com>
 <20231221100016.4022353-2-julia.zhang@amd.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20231221100016.4022353-2-julia.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/21/23 13:00, Julia Zhang wrote:
> From: Daniel Stone <daniels@collabora.com>
> 
> Add a new ioctl to allow the guest VM to discover how the guest
> actually allocated the underlying buffer, which allows buffers to
> be used for GL<->Vulkan interop and through standard window systems.
> It's also a step towards properly supporting modifiers in the guest.
> 
> Signed-off-by: Daniel Stone <daniels@collabora.com>
> Co-developed-by: Julia Zhang <julia.zhang@amd.com> # support query
> stride before it's created
> Signed-off-by: Julia Zhang <julia.zhang@amd.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c   |  1 +
>  drivers/gpu/drm/virtio/virtgpu_drv.h   | 22 ++++++++-
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 66 ++++++++++++++++++++++++++
>  drivers/gpu/drm/virtio/virtgpu_kms.c   |  8 +++-
>  drivers/gpu/drm/virtio/virtgpu_vq.c    | 63 ++++++++++++++++++++++++
>  include/uapi/drm/virtgpu_drm.h         | 21 ++++++++
>  include/uapi/linux/virtio_gpu.h        | 30 ++++++++++++
>  7 files changed, 208 insertions(+), 3 deletions(-)
...
> +static int virtio_gpu_resource_query_layout_ioctl(struct drm_device *dev,
> +						  void *data,
> +						  struct drm_file *file)
> +{
> +	struct drm_virtgpu_resource_query_layout *args = data;
> +	struct virtio_gpu_device *vgdev = dev->dev_private;
> +	struct drm_gem_object *obj = NULL;
> +	struct virtio_gpu_object *bo = NULL;
> +	struct virtio_gpu_query_info bo_info = {0};
> +	int ret = 0;
> +	int i;
> +
> +	if (!vgdev->has_resource_query_layout) {
> +		DRM_ERROR("failing: no RQL on host\n");

Please remove this message

> +		return -EINVAL;

return -ENOSYS

> +	}
> +
> +	if (args->handle > 0) {
> +		obj = drm_gem_object_lookup(file, args->handle);
> +		if (obj == NULL) {
> +			DRM_ERROR("invalid handle 0x%x\n", args->handle);
> +			return -ENOENT;
> +		}
> +		bo = gem_to_virtio_gpu_obj(obj);
> +	}
> +
> +	ret = virtio_gpu_cmd_get_resource_layout(vgdev, &bo_info, args->width,
> +						 args->height, args->format,
> +						 args->bind, bo ? bo->hw_res_handle : 0);

What this special hw_res_handle=0 is doing? Why is it needed?

> +	if (ret)
> +		goto out;
> +
> +	ret = wait_event_timeout(vgdev->resp_wq,
> +				 atomic_read(&bo_info.is_valid),
> +				 5 * HZ);
> +	if (!ret)
> +		goto out;
> +
> +valid:
> +	smp_rmb();
> +	WARN_ON(atomic_read(&bo_info.is_valid));

Please remove this WARN_ON and fix the kernelbot report

> +	args->num_planes = bo_info.num_planes;
> +	args->modifier = bo_info.modifier;
> +	for (i = 0; i < args->num_planes; i++) {
> +		args->planes[i].offset = bo_info.planes[i].offset;
> +		args->planes[i].stride = bo_info.planes[i].stride;
> +	}
> +	for (; i < VIRTIO_GPU_MAX_RESOURCE_PLANES; i++) {
> +		args->planes[i].offset = 0;
> +		args->planes[i].stride = 0;
> +	}
> +	ret = 0;

ret is already 0 here

> +out:
> +	if (obj)
> +		drm_gem_object_put(obj);
> +	return ret;
> +}

...
> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
> index f556fde07b76..547575232376 100644
> --- a/include/uapi/linux/virtio_gpu.h
> +++ b/include/uapi/linux/virtio_gpu.h
> @@ -65,6 +65,11 @@
>   */
>  #define VIRTIO_GPU_F_CONTEXT_INIT        4
>  
> +/*
> + * VIRTIO_GPU_CMD_RESOURCE_QUERY_LAYOUT
> + */
> +#define VIRTIO_GPU_F_RESOURCE_QUERY_LAYOUT 5
> +
>  enum virtio_gpu_ctrl_type {
>  	VIRTIO_GPU_UNDEFINED = 0,
>  
> @@ -95,6 +100,7 @@ enum virtio_gpu_ctrl_type {
>  	VIRTIO_GPU_CMD_SUBMIT_3D,
>  	VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB,
>  	VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB,
> +	VIRTIO_GPU_CMD_RESOURCE_QUERY_LAYOUT,
>  
>  	/* cursor commands */
>  	VIRTIO_GPU_CMD_UPDATE_CURSOR = 0x0300,
> @@ -108,6 +114,7 @@ enum virtio_gpu_ctrl_type {
>  	VIRTIO_GPU_RESP_OK_EDID,
>  	VIRTIO_GPU_RESP_OK_RESOURCE_UUID,
>  	VIRTIO_GPU_RESP_OK_MAP_INFO,
> +	VIRTIO_GPU_RESP_OK_RESOURCE_LAYOUT,
>  
>  	/* error responses */
>  	VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
> @@ -453,4 +460,27 @@ struct virtio_gpu_resource_unmap_blob {
>  	__le32 padding;
>  };
>  
> +/* VIRTIO_GPU_CMD_RESOURCE_QUERY_LAYOUT */
> +struct virtio_gpu_resource_query_layout {
> +	struct virtio_gpu_ctrl_hdr hdr;
> +	__le32 resource_id;
> +	__le32 width;
> +	__le32 height;
> +	__le32 format;
> +	__le32 bind;

64b pad missing

> +};
> +
> +
> +/* VIRTIO_GPU_RESP_OK_RESOURCE_LAYOUT */
> +#define VIRTIO_GPU_RES_MAX_PLANES 4
> +struct virtio_gpu_resp_resource_layout {
> +	struct virtio_gpu_ctrl_hdr hdr;
> +	__le64 modifier;
> +	__le32 num_planes;
> +	struct virtio_gpu_resource_plane {
> +		__le64 offset;
> +		__le32 stride;
> +	} planes[VIRTIO_GPU_RES_MAX_PLANES];
> +};

Virto-spec changes should have a corresponding doc update in [1].

[1]
https://github.com/oasis-tcs/virtio-spec/blob/master/device-types/gpu/description.tex

-- 
Best regards,
Dmitry


