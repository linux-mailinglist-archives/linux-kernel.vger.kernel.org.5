Return-Path: <linux-kernel+bounces-78286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD90861166
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3376E287267
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0B17BAEB;
	Fri, 23 Feb 2024 12:23:09 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F13D5C60F;
	Fri, 23 Feb 2024 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690989; cv=none; b=Q1JQOd/tQOZZ4xEp08UfgGPD5p7cg9C7jDDcUId6WYWK2VY1qWCRV96vsI53KVbLDv/oDbcygza7Oc2gGtVc88RqyUez4xT9NG2PY5qZqzGaqXSWDQn0RYm/kIF4o1IEygCfKWwJ044Lfruwzd0XZirr4335b1CRFv3WGG3aPl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690989; c=relaxed/simple;
	bh=zsIvpoAGN9d289STaiA9COpeVnbLgfYNHqBxTzUt5SU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ke/tyTfP7eADZLA6/FeO1TeQjKSTLzzMG/h2xnFCKOvFp90se48ShjpGL9wbt5vT9WNbKa15J5kTcmmmt0t3eLo8zw7AcLO60gn6MZfeiCCYt6w75ISZZUKoiDQGoeKc7+3KlBn3H3UQK9VZb7+iUl41DZFNjAGY56My9/gOBmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Th8Fn0wTmz6K6nR;
	Fri, 23 Feb 2024 20:19:25 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 17987140F0B;
	Fri, 23 Feb 2024 20:23:04 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 12:23:03 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035;
 Fri, 23 Feb 2024 12:23:03 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
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
Subject: RE: [RFC PATCH v6 02/12] cxl/mbox: Add GET_FEATURE mailbox command
Thread-Topic: [RFC PATCH v6 02/12] cxl/mbox: Add GET_FEATURE mailbox command
Thread-Index: AQHaYAA6Z/8grteajEC0EjChA/BUx7ETG+mAgATIXoA=
Date: Fri, 23 Feb 2024 12:23:03 +0000
Message-ID: <c4a8ecf535df419eae132fda68407760@huawei.com>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
	<20240215111455.1462-3-shiju.jose@huawei.com>
 <20240220111423.00003eae@Huawei.com>
In-Reply-To: <20240220111423.00003eae@Huawei.com>
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

Hi Jonathan,

Thanks for the comments.
I will post  the updated version incorporated with your suggestions in the =
series. =20

>-----Original Message-----
>From: Jonathan Cameron <jonathan.cameron@huawei.com>
>Sent: 20 February 2024 11:14
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-cxl@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
>mm@kvack.org; dan.j.williams@intel.com; dave@stgolabs.net;
>dave.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel.com=
;
>ira.weiny@intel.com; linux-edac@vger.kernel.org; linux-
>kernel@vger.kernel.org; david@redhat.com; Vilas.Sridharan@amd.com;
>leo.duran@amd.com; Yazen.Ghannam@amd.com; rientjes@google.com;
>jiaqiyan@google.com; tony.luck@intel.com; Jon.Grimm@amd.com;
>dave.hansen@linux.intel.com; rafael@kernel.org; lenb@kernel.org;
>naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
>somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
>duenwen@google.com; mike.malvestuto@intel.com; gthelen@google.com;
>wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>=
;
>kangkang.shen@futurewei.com; wanghuiqiang <wanghuiqiang@huawei.com>;
>Linuxarm <linuxarm@huawei.com>
>Subject: Re: [RFC PATCH v6 02/12] cxl/mbox: Add GET_FEATURE mailbox
>command
>
>On Thu, 15 Feb 2024 19:14:44 +0800
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add support for GET_FEATURE mailbox command.
>>
>> CXL spec 3.1 section 8.2.9.6 describes optional device specific features=
.
>> The settings of a feature can be retrieved using Get Feature command.
>Hi Shiju
>
>I think this needs to be more complex so that this utility function gets t=
he whole
>feature, not just a section of it (subject to big enough buffer being avai=
lable etc).
>We don't want the higher level code to have to deal with the complexity of=
 small
>mailboxes.
Sure.

>
>A few other things inline.
>
>Jonathan
>
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  drivers/cxl/core/mbox.c | 22 ++++++++++++++++++++++
>>  drivers/cxl/cxlmem.h    | 23 +++++++++++++++++++++++
>>  2 files changed, 45 insertions(+)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c index
>> 191f51f3df0e..f43189b6859a 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1313,6 +1313,28 @@ int cxl_get_supported_features(struct
>> cxl_memdev_state *mds,  }
>> EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
>>
>> +int cxl_get_feature(struct cxl_memdev_state *mds,
>> +		    struct cxl_mbox_get_feat_in *pi, void *feat_out)
>
>Comments below on this signature.  Key is I'd expect this function to deal=
 with
>potential need for multiple requests (small mailbox size compared to the s=
ize of
>the output data being read).
>
>To test that we'd probably have to tweak the qemu code to use a smaller
>mailbox.
>Or fake that in here so that we do multiple smaller reads.
Sure.
>
>> +{
>> +	struct cxl_mbox_cmd mbox_cmd;
>> +	int rc;
>> +
>> +	mbox_cmd =3D (struct cxl_mbox_cmd) {
>> +		.opcode =3D CXL_MBOX_OP_GET_FEATURE,
>> +		.size_in =3D sizeof(*pi),
>> +		.payload_in =3D pi,
>> +		.size_out =3D le16_to_cpu(pi->count),
>> +		.payload_out =3D feat_out,
>> +		.min_out =3D le16_to_cpu(pi->count),
>
>Are there feature with variable responses sizes?  I think there will be.
>size_out should be the size of the buffer, but min_out should be the size =
of the
>particular feature data header - note these will change as we iterate over
>multiple messages.
Sure.

>
>
>> +	};
>> +	rc =3D cxl_internal_send_cmd(mds, &mbox_cmd);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	return 0;
>I think this should return the size to the caller, rather than 0 on succes=
s.
I will change.

>
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
>> +
>>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>>  		       struct cxl_region *cxlr)
>>  {
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h index
>> 23e4d98b9bae..eaecc3234cfd 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -530,6 +530,7 @@ enum cxl_opcode {
>>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	=3D 0x0400,
>>  	CXL_MBOX_OP_GET_LOG		=3D 0x0401,
>>  	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	=3D 0x0500,
>> +	CXL_MBOX_OP_GET_FEATURE		=3D 0x0501,
>>  	CXL_MBOX_OP_IDENTIFY		=3D 0x4000,
>>  	CXL_MBOX_OP_GET_PARTITION_INFO	=3D 0x4100,
>>  	CXL_MBOX_OP_SET_PARTITION_INFO	=3D 0x4101,
>> @@ -757,6 +758,26 @@ struct cxl_mbox_get_supp_feats_out {
>>  	struct cxl_mbox_supp_feat_entry feat_entries[];  } __packed;
>>
>> +/* Get Feature CXL 3.1 Spec 8.2.9.6.2 */
>> +/*
>> + * Get Feature input payload
>> + * CXL rev 3.1 section 8.2.9.6.2 Table 8-99  */
>> +/* Get Feature : Payload in selection */
>
>Naming of enum is good enough that I don't think we need this particular
>comment.
I will change.

>
>> +enum cxl_get_feat_selection {
>> +	CXL_GET_FEAT_SEL_CURRENT_VALUE,
>> +	CXL_GET_FEAT_SEL_DEFAULT_VALUE,
>> +	CXL_GET_FEAT_SEL_SAVED_VALUE,
>> +	CXL_GET_FEAT_SEL_MAX
>> +};
>> +
>> +struct cxl_mbox_get_feat_in {
>> +	uuid_t uuid;
>> +	__le16 offset;
>> +	__le16 count;
>> +	u8 selection;
>> +}  __packed;
>> +
>>  /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */  struct
>> cxl_mbox_poison_in {
>>  	__le64 offset;
>> @@ -891,6 +912,8 @@ int cxl_set_timestamp(struct cxl_memdev_state
>> *mds);  int cxl_get_supported_features(struct cxl_memdev_state *mds,
>>  			       struct cxl_mbox_get_supp_feats_in *pi,
>>  			       void *feats_out);
>> +int cxl_get_feature(struct cxl_memdev_state *mds,
>> +		    struct cxl_mbox_get_feat_in *pi, void *feat_out);
>
>For this I'd expect us to wrap up the need for multi messages inside this.
>So this would then just take the feature index, a size for the output buff=
er overall
>size, plus min acceptable response size and a selection enum value.
Sure.

>
>int cxl_get_feature(struct cxl_memdev_state *mds,
>		    uuid_t feat,
>		    void *feat_out, size_t feat_out_min_size,
>		    size_t feat_out_size);
>
>>  int cxl_poison_state_init(struct cxl_memdev_state *mds);  int
>> cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>>  		       struct cxl_region *cxlr);

Thanks,
Shiju


