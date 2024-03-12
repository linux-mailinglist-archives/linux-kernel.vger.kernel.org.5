Return-Path: <linux-kernel+bounces-100034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 297D787911C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44481F22DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0A678289;
	Tue, 12 Mar 2024 09:41:35 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AF278273;
	Tue, 12 Mar 2024 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236495; cv=none; b=ZbTOulhdLw+++OtY683nKbzLHkEDoCNXrIW3FESjfrBDC8IJM8yQLJ3CyoctQavDA5YH8WuaL4+DT+FyU4Q9rvz+e1rqsOtepY9T3DdeRD+tJ1c/a//WkpObsnbfTKbFvpWfP/rNkH4KJd0S7y4H75RMORduz5ECfAW0nJLZax8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236495; c=relaxed/simple;
	bh=9BVd3T4GZqlg+poIfhaoPYk3KkThuqvVtjsxrrpVzUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nXsjDloJSJjTY1IYr81d91FJtZJfe9iTyfdcFrYgOo2ukmQqw19ry4ICQz/avYpvbtpPGC9V+phYCf4Wq8KpEjge7+eO3334C8ShFZ3aN/NWFnDOeg2DDTLr0X4o3bWuXI1m6DXx8GYb1Dl1S8XeIavYxCYu9AarsH7yPI10UVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tv7pW0sy4z688hZ;
	Tue, 12 Mar 2024 17:37:23 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (unknown [7.191.162.67])
	by mail.maildlp.com (Postfix) with ESMTPS id 5738E140D1D;
	Tue, 12 Mar 2024 17:41:28 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 09:41:27 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035;
 Tue, 12 Mar 2024 09:41:27 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [RFC PATCH v7 03/12] cxl/mbox: Add SET_FEATURE mailbox command
Thread-Topic: [RFC PATCH v7 03/12] cxl/mbox: Add SET_FEATURE mailbox command
Thread-Index: AQHaZmXa2rf54FiQvUO4a7U5LboEzbEzJw+AgADJeeA=
Date: Tue, 12 Mar 2024 09:41:27 +0000
Message-ID: <b6aa1dd19ab44b7db7b9aa1318c5d8b0@huawei.com>
References: <20240223143723.1574-1-shiju.jose@huawei.com>
 <20240223143723.1574-4-shiju.jose@huawei.com> <Ze91l0jz_DZR9jjx@debian>
In-Reply-To: <Ze91l0jz_DZR9jjx@debian>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Fan,

>-----Original Message-----
>From: fan <nifan.cxl@gmail.com>
>Sent: 11 March 2024 21:20
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-cxl@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
>mm@kvack.org; dan.j.williams@intel.com; dave@stgolabs.net; Jonathan
>Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; david@redhat.com=
;
>Vilas.Sridharan@amd.com; leo.duran@amd.com; Yazen.Ghannam@amd.com;
>rientjes@google.com; jiaqiyan@google.com; tony.luck@intel.com;
>Jon.Grimm@amd.com; dave.hansen@linux.intel.com; rafael@kernel.org;
>lenb@kernel.org; naoya.horiguchi@nec.com; james.morse@arm.com;
>jthoughton@google.com; somasundaram.a@hpe.com;
>erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
>mike.malvestuto@intel.com; gthelen@google.com;
>wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>=
;
>kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
>Linuxarm <linuxarm@huawei.com>
>Subject: Re: [RFC PATCH v7 03/12] cxl/mbox: Add SET_FEATURE mailbox
>command
>
>On Fri, Feb 23, 2024 at 10:37:14PM +0800, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add support for SET_FEATURE mailbox command.
>>
>> CXL spec 3.1 section 8.2.9.6 describes optional device specific features=
.
>> CXL devices supports features with changeable attributes.
>> The settings of a feature can be optionally modified using Set Feature
>> command.
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  drivers/cxl/core/mbox.c | 67
>+++++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxlmem.h    | 30 ++++++++++++++++++
>>  2 files changed, 97 insertions(+)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c index
>> c078e62ea194..d1660bd20bdb 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1366,6 +1366,73 @@ size_t cxl_get_feature(struct cxl_memdev_state
>> *mds,  }  EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
>>
>> +int cxl_set_feature(struct cxl_memdev_state *mds,
>> +		    const uuid_t feat_uuid, u8 feat_version,
>> +		    void *feat_data, size_t feat_data_size,
>> +		    u8 feat_flag)
>> +{
>> +	struct cxl_memdev_set_feat_pi {
>> +		struct cxl_mbox_set_feat_hdr hdr;
>> +		u8 feat_data[];
>> +	}  __packed;
>> +	size_t data_in_size, data_sent_size =3D 0;
>> +	struct cxl_mbox_cmd mbox_cmd;
>> +	size_t hdr_size;
>> +	int rc =3D 0;
>> +
>> +	struct cxl_memdev_set_feat_pi *pi __free(kfree) =3D
>> +					kmalloc(mds->payload_size,
>GFP_KERNEL);
>> +	pi->hdr.uuid =3D feat_uuid;
>> +	pi->hdr.version =3D feat_version;
>> +	feat_flag &=3D ~CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK;
>> +	hdr_size =3D sizeof(pi->hdr);
>> +	/*
>> +	 * Check minimum mbox payload size is available for
>> +	 * the feature data transfer.
>> +	 */
>> +	if (hdr_size + 10 > mds->payload_size)
>
>Where does this magic number come from?

This represents minimum extra number of bytes to be available in the mail b=
ox
for storing the actual feature data to work with multipart feature data tra=
nsfers.
This will be set as a definition in the next version and however not sure t=
he
best value to be set.
>
>Fan
>
>> +		return -ENOMEM;
>> +
>> +	if ((hdr_size + feat_data_size) <=3D mds->payload_size) {
>> +		pi->hdr.flags =3D cpu_to_le32(feat_flag |
>> +
>CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER);
>> +		data_in_size =3D feat_data_size;
>> +	} else {
>> +		pi->hdr.flags =3D cpu_to_le32(feat_flag |
>> +
>CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER);
>> +		data_in_size =3D mds->payload_size - hdr_size;
>> +	}
>> +
>> +	do {
>> +		pi->hdr.offset =3D cpu_to_le16(data_sent_size);
>> +		memcpy(pi->feat_data, feat_data + data_sent_size,
>data_in_size);
>> +		mbox_cmd =3D (struct cxl_mbox_cmd) {
>> +			.opcode =3D CXL_MBOX_OP_SET_FEATURE,
>> +			.size_in =3D hdr_size + data_in_size,
>> +			.payload_in =3D pi,
>> +		};
>> +		rc =3D cxl_internal_send_cmd(mds, &mbox_cmd);
>> +		if (rc < 0)
>> +			return rc;
>> +
>> +		data_sent_size +=3D data_in_size;
>> +		if (data_sent_size >=3D feat_data_size)
>> +			return 0;
>> +
>> +		if ((feat_data_size - data_sent_size) <=3D (mds->payload_size -
>hdr_size)) {
>> +			data_in_size =3D feat_data_size - data_sent_size;
>> +			pi->hdr.flags =3D cpu_to_le32(feat_flag |
>> +
>CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER);
>> +		} else {
>> +			pi->hdr.flags =3D cpu_to_le32(feat_flag |
>> +
>CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER);
>> +		}
>> +	} while (true);
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_feature, CXL);
>> +
>>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>>  		       struct cxl_region *cxlr)
>>  {
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h index
>> bcfefff062a6..a8d4104afa53 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -531,6 +531,7 @@ enum cxl_opcode {
>>  	CXL_MBOX_OP_GET_LOG		=3D 0x0401,
>>  	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	=3D 0x0500,
>>  	CXL_MBOX_OP_GET_FEATURE		=3D 0x0501,
>> +	CXL_MBOX_OP_SET_FEATURE		=3D 0x0502,
>>  	CXL_MBOX_OP_IDENTIFY		=3D 0x4000,
>>  	CXL_MBOX_OP_GET_PARTITION_INFO	=3D 0x4100,
>>  	CXL_MBOX_OP_SET_PARTITION_INFO	=3D 0x4101,
>> @@ -773,6 +774,31 @@ struct cxl_mbox_get_feat_in {
>>  	u8 selection;
>>  }  __packed;
>>
>> +/* Set Feature CXL 3.1 Spec 8.2.9.6.3 */
>> +/*
>> + * Set Feature input payload
>> + * CXL rev 3.1 section 8.2.9.6.3 Table 8-101  */
>> +/* Set Feature : Payload in flags */
>> +#define CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK	GENMASK(2, 0)
>> +enum cxl_set_feat_flag_data_transfer {
>> +	CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER,
>> +	CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER,
>> +	CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER,
>> +	CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER,
>> +	CXL_SET_FEAT_FLAG_ABORT_DATA_TRANSFER,
>> +	CXL_SET_FEAT_FLAG_DATA_TRANSFER_MAX
>> +};
>> +#define CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET	BIT(3)
>> +
>> +struct cxl_mbox_set_feat_hdr {
>> +	uuid_t uuid;
>> +	__le32 flags;
>> +	__le16 offset;
>> +	u8 version;
>> +	u8 rsvd[9];
>> +}  __packed;
>> +
>>  /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */  struct
>> cxl_mbox_poison_in {
>>  	__le64 offset;
>> @@ -912,6 +938,10 @@ size_t cxl_get_feature(struct cxl_memdev_state
>*mds,
>>  		       size_t feat_out_size,
>>  		       size_t feat_out_min_size,
>>  		       enum cxl_get_feat_selection selection);
>> +int cxl_set_feature(struct cxl_memdev_state *mds,
>> +		    const uuid_t feat_uuid, u8 feat_version,
>> +		    void *feat_data, size_t feat_data_size,
>> +		    u8 feat_flag);
>>  int cxl_poison_state_init(struct cxl_memdev_state *mds);  int
>> cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>>  		       struct cxl_region *cxlr);
>> --
>> 2.34.1
>>

Thanks,
Shiju

