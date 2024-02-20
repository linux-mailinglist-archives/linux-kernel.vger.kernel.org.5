Return-Path: <linux-kernel+bounces-72886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8604285BA19
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2D31C212F2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16406664B6;
	Tue, 20 Feb 2024 11:14:32 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B219760DF0;
	Tue, 20 Feb 2024 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427671; cv=none; b=t5JzTEh+m4sYlho89uUk7h+JAR9FDcX4RI24u2g8pR2HXFKMI0mdmErR7Lcbe+4tVNq3outOKbiGE0ubRZ/g2CIMALQz8f/XIbP2ZRY4u33M3ln6+PutXNbqcIfHMsMQIB1wYAF2piz+bvzguuU3MVD4aVplPXj/y1swmDCtOGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427671; c=relaxed/simple;
	bh=YnyMyA2hDVuzoNVumqBKaS5+hcq6Bw/UggiiX/iZvbo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiER62G4zhi2TI/4Jhj1fkR50Jxug9AAAXpMiNozJhd/ZDHGfPUaVlXrzsfKPa9cHVV4Y5WxITJ+zvrY5vaLgsAgVL8hLFyOMLXWI0sG5mJaFy0WHzIOh3TEyMaipBAPluwE+nPh7O4cC25u4VwQ0nzXtjn3qo+88OrjbrrKUQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TfGsZ39l6z6K6Sy;
	Tue, 20 Feb 2024 19:10:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CA3D4140A70;
	Tue, 20 Feb 2024 19:14:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 11:14:24 +0000
Date: Tue, 20 Feb 2024 11:14:23 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>
Subject: Re: [RFC PATCH v6 02/12] cxl/mbox: Add GET_FEATURE mailbox command
Message-ID: <20240220111423.00003eae@Huawei.com>
In-Reply-To: <20240215111455.1462-3-shiju.jose@huawei.com>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
	<20240215111455.1462-3-shiju.jose@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 15 Feb 2024 19:14:44 +0800
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for GET_FEATURE mailbox command.
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> The settings of a feature can be retrieved using Get Feature command.
Hi Shiju

I think this needs to be more complex so that this utility function gets
the whole feature, not just a section of it (subject to big enough buffer
being available etc).  We don't want the higher level code to have to
deal with the complexity of small mailboxes.

A few other things inline.

Jonathan

> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/mbox.c | 22 ++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 23 +++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 191f51f3df0e..f43189b6859a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1313,6 +1313,28 @@ int cxl_get_supported_features(struct cxl_memdev_state *mds,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
>  
> +int cxl_get_feature(struct cxl_memdev_state *mds,
> +		    struct cxl_mbox_get_feat_in *pi, void *feat_out)

Comments below on this signature.  Key is I'd expect this function to deal
with potential need for multiple requests (small mailbox size compared to
the size of the output data being read).

To test that we'd probably have to tweak the qemu code to use a smaller mailbox.
Or fake that in here so that we do multiple smaller reads.

> +{
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int rc;
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_FEATURE,
> +		.size_in = sizeof(*pi),
> +		.payload_in = pi,
> +		.size_out = le16_to_cpu(pi->count),
> +		.payload_out = feat_out,
> +		.min_out = le16_to_cpu(pi->count),

Are there feature with variable responses sizes?  I think there will be.
size_out should be the size of the buffer, but min_out should be
the size of the particular feature data header - note these will change
as we iterate over multiple messages.


> +	};
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	return 0;
I think this should return the size to the caller, rather than 0 on success.

> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
> +
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 23e4d98b9bae..eaecc3234cfd 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -530,6 +530,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
>  	CXL_MBOX_OP_GET_LOG		= 0x0401,
>  	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
> +	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> @@ -757,6 +758,26 @@ struct cxl_mbox_get_supp_feats_out {
>  	struct cxl_mbox_supp_feat_entry feat_entries[];
>  } __packed;
>  
> +/* Get Feature CXL 3.1 Spec 8.2.9.6.2 */
> +/*
> + * Get Feature input payload
> + * CXL rev 3.1 section 8.2.9.6.2 Table 8-99
> + */
> +/* Get Feature : Payload in selection */

Naming of enum is good enough that I don't think we need
this particular comment.

> +enum cxl_get_feat_selection {
> +	CXL_GET_FEAT_SEL_CURRENT_VALUE,
> +	CXL_GET_FEAT_SEL_DEFAULT_VALUE,
> +	CXL_GET_FEAT_SEL_SAVED_VALUE,
> +	CXL_GET_FEAT_SEL_MAX
> +};
> +
> +struct cxl_mbox_get_feat_in {
> +	uuid_t uuid;
> +	__le16 offset;
> +	__le16 count;
> +	u8 selection;
> +}  __packed;
> +
>  /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
>  struct cxl_mbox_poison_in {
>  	__le64 offset;
> @@ -891,6 +912,8 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_get_supported_features(struct cxl_memdev_state *mds,
>  			       struct cxl_mbox_get_supp_feats_in *pi,
>  			       void *feats_out);
> +int cxl_get_feature(struct cxl_memdev_state *mds,
> +		    struct cxl_mbox_get_feat_in *pi, void *feat_out);

For this I'd expect us to wrap up the need for multi messages inside this.
So this would then just take the feature index, a size for the output buffer
overall size, plus min acceptable response size and a selection enum value.

int cxl_get_feature(struct cxl_memdev_state *mds,
		    uuid_t feat,
		    void *feat_out, size_t feat_out_min_size,
		    size_t feat_out_size);

>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr);


