Return-Path: <linux-kernel+bounces-72869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B0D85B9D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9071F2430E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8F665BD9;
	Tue, 20 Feb 2024 11:03:05 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490AF629FD;
	Tue, 20 Feb 2024 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426984; cv=none; b=alUaowNew/1adYUnakUVtIkiMrKhoAHUjSIWPo4QrHuRapU8D0IuK8F3L31TJeCUaCizcJBS8bHZrOCpK14KNvbLs4NSTmO1dQgFmnkl5dtCOnykSqaK9L78shD8qgxgnE7iw1DDqkDBE9cyVh9Ek4EW++Lbx01jI6BKWclXGa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426984; c=relaxed/simple;
	bh=zuvLddHIXbqnQ9+Zwy+M4L650QAJdwFPOIroz3/ec9o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nu4GqVASipKVT2vbxDbHJOfYlP6ZeGns2H4Ex5uaO5/VE+11tiXNtufkG67pDgpLk23cDrFfK7z+Ei7IxZY9xjTUBZaneep471oNrfZG0bX0j7OxFhB56kBZ2pX4YlH0iWVS/AvDBd+HKVzkogg2b5vGgekLx4kF3hQE9oSw5lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TfGcM5KXGz6K6QG;
	Tue, 20 Feb 2024 18:58:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 18AFD140B54;
	Tue, 20 Feb 2024 19:02:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 11:02:58 +0000
Date: Tue, 20 Feb 2024 11:02:56 +0000
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
Subject: Re: [RFC PATCH v6 01/12] cxl/mbox: Add GET_SUPPORTED_FEATURES
 mailbox command
Message-ID: <20240220110256.00001586@Huawei.com>
In-Reply-To: <20240215111455.1462-2-shiju.jose@huawei.com>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
	<20240215111455.1462-2-shiju.jose@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 15 Feb 2024 19:14:43 +0800
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
>=20
> Add support for GET_SUPPORTED_FEATURES mailbox command.
>=20
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> CXL devices supports features with changeable attributes.
> Get Supported Features retrieves the list of supported device specific
> features. The settings of a feature can be retrieved using Get Feature
> and optionally modified using Set Feature.
>=20
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Hi Shiju,

Some comment inline.

Mostly just naming suggestions. Actual functionality looks good to me.


> ---
>  drivers/cxl/core/mbox.c | 23 +++++++++++++++
>  drivers/cxl/cxlmem.h    | 62 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+)
>=20
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 27166a411705..191f51f3df0e 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1290,6 +1290,29 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
> =20
> +int cxl_get_supported_features(struct cxl_memdev_state *mds,
> +						struct cxl_mbox_get_supp_feats_in *pi,
> +						void *feats_out)

Odd indent.  Align the later lines with s of struct

Comments on input types in header below.


> +{
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int rc;
> +
> +	mbox_cmd =3D (struct cxl_mbox_cmd) {
> +		.opcode =3D CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
> +		.size_in =3D sizeof(*pi),
> +		.payload_in =3D pi,
> +		.size_out =3D le32_to_cpu(pi->count),
> +		.payload_out =3D feats_out,
> +		.min_out =3D sizeof(struct cxl_mbox_get_supp_feats_out),
feats_out should be typed, in which case this becomes
sizeof(*feats_out)

> +	};
> +	rc =3D cxl_internal_send_cmd(mds, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
> +
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 5303d6942b88..23e4d98b9bae 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -529,6 +529,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_SET_TIMESTAMP	=3D 0x0301,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	=3D 0x0400,
>  	CXL_MBOX_OP_GET_LOG		=3D 0x0401,
> +	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	=3D 0x0500,
>  	CXL_MBOX_OP_IDENTIFY		=3D 0x4000,
>  	CXL_MBOX_OP_GET_PARTITION_INFO	=3D 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	=3D 0x4101,
> @@ -698,6 +699,64 @@ struct cxl_mbox_set_timestamp_in {
> =20
>  } __packed;
> =20
> +/* Get Supported Features CXL 3.1 Spec 8.2.9.6.1 */
> +/*
> + * Get Supported Features input payload
> + * CXL rev 3.1 section 8.2.9.6.1 Table 8-95
> + */
> +struct cxl_mbox_get_supp_feats_in {
> +	__le32 count;
> +	__le16 start_index;
> +	u16 reserved;

=46rom a local style point of view using a u16 for reserved is
a new style choice - best to avoid that - most common option looks to
be

	u8 rsvd[2];

> +} __packed;
> +
> +/*
> + * Get Supported Features Supported Feature Entry
> + * CXL rev 3.1 section 8.2.9.6.1 Table 8-97
> + */
> +/* Supported Feature Entry : Payload out attribute flags */
> +#define CXL_FEAT_ENTRY_FLAG_CHANGABLE	BIT(0)
> +#define CXL_FEAT_ENTRY_FLAG_DEEPEST_RESET_PERSISTENCE_MASK	GENMASK(3, 1)
> +#define CXL_FEAT_ENTRY_FLAG_PERSIST_ACROSS_FIRMWARE_UPDATE	BIT(4)
> +#define CXL_FEAT_ENTRY_FLAG_SUPPORT_DEFAULT_SELECTION	BIT(5)
> +#define CXL_FEAT_ENTRY_FLAG_SUPPORT_SAVED_SELECTION	BIT(6)
> +
> +enum cxl_feat_attr_value_persistence {
> +	CXL_FEAT_ATTR_VALUE_PERSISTENCE_NONE,
> +	CXL_FEAT_ATTR_VALUE_PERSISTENCE_CXL_RESET,
> +	CXL_FEAT_ATTR_VALUE_PERSISTENCE_HOT_RESET,
> +	CXL_FEAT_ATTR_VALUE_PERSISTENCE_WARM_RESET,
> +	CXL_FEAT_ATTR_VALUE_PERSISTENCE_COLD_RESET,
> +	CXL_FEAT_ATTR_VALUE_PERSISTENCE_MAX
> +};
> +
> +#define CXL_FEAT_ENTRY_FLAG_PERSISTENCE_ACROSS_FW_UPDATE_MASK	BIT(4)
Not sure there is benefit in defining mask for single bit fields.
Or if there is don't define the value above.
> +#define CXL_FEAT_ENTRY_FLAG_PERSIST_ACROSS_FIRMWARE_UPDATE	BIT(4)

Either is probably fine, just not both!

> +#define CXL_FEAT_ENTRY_FLAG_PERSISTENCE_DEFAULT_SEL_SUPPORT_MASK	BIT(5)
> +#define CXL_FEAT_ENTRY_FLAG_PERSISTENCE_SAVED_SEL_SUPPORT_MASK	BIT(6)
> +
> +struct cxl_mbox_supp_feat_entry {
> +	uuid_t uuid;
> +	__le16 feat_index;

Given it's in a feat entry, could drop 'feat' as redundant info.

	__le16 index;
	__le16 get_size;
etc

> +	__le16 get_feat_size;
> +	__le16 set_feat_size;
> +	__le32 attr_flags;
> +	u8 get_feat_version;
> +	u8 set_feat_version;
> +	__le16 set_feat_effects;
> +	u8 rsvd[18];
> +}  __packed;
> +
> +/*
> + * Get Supported Features output payload
> + * CXL rev 3.1 section 8.2.9.6.1 Table 8-96
> + */
> +struct cxl_mbox_get_supp_feats_out {
> +	__le16 entries;
> +	__le16 nsuppfeats_dev;
Probably don't need the _dev postfix.  Command being sent to a device
so that doesn't add much.

I looked at naming in similar cases.  For mailbox clear we have nr_recs,
so perhaps nr_supported ?

> +	u32 reserved;
	u8 rsvd[4];
as above - match the local syle.
> +	struct cxl_mbox_supp_feat_entry feat_entries[];
> +} __packed;
> +
>  /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
>  struct cxl_mbox_poison_in {
>  	__le64 offset;
> @@ -829,6 +888,9 @@ void cxl_event_trace_record(const struct cxl_memdev *=
cxlmd,
>  			    enum cxl_event_type event_type,
>  			    const uuid_t *uuid, union cxl_event *evt);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
> +int cxl_get_supported_features(struct cxl_memdev_state *mds,
> +			       struct cxl_mbox_get_supp_feats_in *pi,
> +			       void *feats_out);


Don't use a void * for that output data.  It should be a
struct cxl_mbox_get_supp_feats_out *

For the input, the other similar functions are providing parameters
directly, not wrapped up in a structure.  Easy enough to do that here
as well as we only need
u32 count, u16 start_index
instead of pi


>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr);


