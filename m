Return-Path: <linux-kernel+bounces-98108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F4A87753D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 04:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B431C20D4C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 03:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EDC11C87;
	Sun, 10 Mar 2024 03:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VCEXloP8"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120DB847C
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 03:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710042582; cv=fail; b=faAp0Xr6jJvRmYim694Qa/gZQXWkA3Hk/o2+40Xjw4rSNQsVzhaATbeYZJPNfWu5Aa8Xv9UThxLAWIvVBo0Yu1b5nZkjQDWiu04A533tY91vxii6OAK5vh2MJoOiV46sa84nogBZRSzIibrdLxWaGmn1gGosu7oczadI7X6V1Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710042582; c=relaxed/simple;
	bh=IFnaB297gZQOzvHHH0+AJAAHcvfkd+Mij4ksvN8JMp4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MGT1J4OE3creSk+F0LeY4MXo8E6K5qewZGJVKYcDChuT29aTCjb2B/+v8h8VQGqiVQGnGhItIj1JdjJC3Fu+ekNWImwaNGBSbNSmJaSZ2oz5F3ltpELZW78vkqTuNrqE8iENzCCL26YWzk/v8dUAjnGuuwMN6MVBbvgsc7/Evmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VCEXloP8; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcStmSQY1FrVBn3R/+rwS5+CbQYu9IXW3fQzGbwlw2PoPtu1vLppAoP0wgTanLRqcdJu6gnWzUac5ewW5dCMR3QesJox//gY+H6+XJR5C3508D40QdBbwNERZKw8ZEXBgbskcOzqloDI7jHgM545FJFQh0qVhQcXoGV0J3An4SoK+B7aViLrYeblT1eSk8PIDtSDLV3RC5AuxC7/U4U2G5eiJ4gMbOciHHLWQM7KFhfFypETCPYy+hNmZ36qVcIY6Nr4Uz/OYO70iAurz22T0ZQbwEI5L2GXC3L2914CFgfuu+oQe0XjbrKeZNTdENkB+mGBuio4ef3LxlJKSGyZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFnaB297gZQOzvHHH0+AJAAHcvfkd+Mij4ksvN8JMp4=;
 b=YUs8fRs4atCg5jQZS5U0o1Ggr8O+jXymjkpL4qgUBNMoZjeucryXOhK1fH9n90iCxJvjb/UdE5DJA11enut0WCE6999/A2GNYY3X1Z2blJtnG80dLRs6ACIoKEU6F8vytBPFltrbejofd0o56lLN3LFHV8jLRMZKYiFTb8G5Wh9W+MHxe+WTUDQSJdVCg4sGq8TFZZoCIKXTvCGlN0zWCj5+PRk/ydyflp/bC2KHRzipNKBJVgpfLhYxZ0ZHzd2lTFQeAf+v62DqJH/9U9hWk7jLTMWSVoArt1vV6EQjwdrU0wZHa9paBlMpXTPbHF/XqKJs6RoMxsk9GkK8a0AbKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFnaB297gZQOzvHHH0+AJAAHcvfkd+Mij4ksvN8JMp4=;
 b=VCEXloP8Z3PFojno5Qo1DQ7AAKaEjjpuT2asRUiwsx2l272PZwfa5Zhn8W6DRKO4JoYXRPyF0KqXp+TakucmfJB9A3pO+nc2GvQglrJFrm7A+zSFZIsqUA0kUT/FJBDdk2ecjYNYr+nS8WEMFLfOcDaiPx0gnlBNnKzhdEFHbXyaA1lfNfi36oBkxsNiMpbVA45sYSX78gtKNVciEhIgc3TZXE/N/vI0rgK/9V+v6cUYwr6g/bFuhNjVY+kNfteWevwdeKDlJRX8GrEBv78ai3MDNLGqYbTtaouqlyxa5g0COb7LVKXiRz+ZynydbiY0kOdZczWt7XMUN4V31wBjCw==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sun, 10 Mar
 2024 03:49:36 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2%5]) with mapi id 15.20.7316.032; Sun, 10 Mar 2024
 03:49:36 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Jason Gunthorpe
	<jgg@nvidia.com>
CC: "maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "will@kernel.org" <will@kernel.org>, Aniket Agashe
	<aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
	<kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Alistair Popple
	<apopple@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, Dan Williams
	<danw@nvidia.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] KVM: arm64: determine memory type from VMA
Thread-Topic: [PATCH v1 1/2] KVM: arm64: determine memory type from VMA
Thread-Index:
 AQHZ4bc9eKM9qzFPEkOCPCVLZRI57LA7iuuAgAAK/gCAB7HcAIAACxYAgAAlfgCAABHzAIABh9MAgAAOv4CAAWqOgIDq6ccH
Date: Sun, 10 Mar 2024 03:49:36 +0000
Message-ID:
 <SA1PR12MB7199AB860E0C76B80B421C66B0252@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-2-ankita@nvidia.com> <ZR7hKYU1Wj+VTqpO@arm.com>
 <20231005165458.GM682044@nvidia.com> <ZSVe0nb02S4kz5D2@arm.com>
 <20231010150502.GM3952@nvidia.com> <ZSWHkvhutlnvVLUZ@arm.com>
 <20231010182328.GS3952@nvidia.com> <ZSbfUNLwDkaYL4ts@arm.com>
 <20231011183839.GC3952@nvidia.com> <ZSgb0WBSsXHHYJT0@arm.com>
In-Reply-To: <ZSgb0WBSsXHHYJT0@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|DS7PR12MB5982:EE_
x-ms-office365-filtering-correlation-id: 7d57bfed-2025-4fb6-a2ef-08dc40b51aa9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +ubToWL19CsqHFN0n+zypFWNCddIli2QgkVRmqClCmMawhPeYvvih8AAInhZcxKV2ik2Jg5IMvMLB15A1Dr5RjhNgGEuMhDjUXMGCi8oYSk7h0yN4+JbQbYH0XjRTjidW7xrklQYzkCgpH0HrlAeS0vDhgzQdo168/t42PtGHHR7sIjiygoQAEHJDK1vb4iSJwe7v97shWIRsL+RwlhijtBvO6EoLzEvGwLIOAA5KyhJs6xPBVUrZ3jn3dS7KBE6VKz260LRQCId2PI1qOXwe+ocxuXMD1mCK7htpJv1S+cycCt/rO6Xvr/PNj5F9jTVQoSdFOP76uJlsRUi86PJWodOglnYiqGRDra38+lDVV4pLO7vVQHEwf5qP8qyAd+t6HVmx+ACwFQv6y+yfHYEn62Y3ufiol/glXcobPk99bivbSxybnwWeKoLSyFGXifcIboCocibLHW9/r0sf+tunREtCEZgem/8DN0KZeKIrGIjY1cFdSoGCriYXd8MH2b/7Cyoclzl/+S3bCK0vBLb+ihzFxvDHuUQuVaV1xhZQosod1wspEiWxZI2Y2Ly98DtNZe+wFeksUxzzPeWKAEN7WbhR8hmt04oFtm4gQi/4cAAIuQuaUYr4AG47UX0YDAe1B9PDkR5cVMt6/kGPxUNVtWxMuss3RutRx9r5vVmamPPaKdgbBDoxo8y+knXb4ImmhBvuniTjxv1W/E4B7ig0eCMUqNYbfaP0eUYdpVe9B4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7199.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qFlkR63l09EL99uoPXRGplmeJlKgyIao0Tne2+telPjdULuzbNOpAxqqR7?=
 =?iso-8859-1?Q?TMxxSZIvwX9tGoi1nA1VziRBEBRaHFkNX5x4kQKgDAfstdyYd1W74Nl8WU?=
 =?iso-8859-1?Q?vTOdCUTi5NRIneaTqV5RTKXBvQtNww2/7K9OllpOF6BKCCrcVEq46Ssg9p?=
 =?iso-8859-1?Q?cgUUxrD1f+rDyvPVid/AJd8MH9zXyutWeaxPJirflowbJnx/e4MFO/s817?=
 =?iso-8859-1?Q?gCtnd4XgVvn69G4l8lkTKgz25lKx5WSkS9Zr7pBbtLAC/1H0lbwipUQveB?=
 =?iso-8859-1?Q?0cQffXGuUGUxGa2jrnfTKtDEHh9yztD4a06/90/kwd864FPP6uZoQkYUST?=
 =?iso-8859-1?Q?83mxCyCHnkD1QFSvPJfwsyP3wUFY6MzVuOita3ax4brOQJObKd5FjV273O?=
 =?iso-8859-1?Q?RO/Qp3jQPhIlbE00+3AHIjqxLnGdaoFC6A4DayBYuD2YKCKnHYVSL75Ens?=
 =?iso-8859-1?Q?7HSIcm+OlDQuha1bHjTJsW2RBvqVf2J4EVmSlhPltVR+LYdl8Vsi4n1FvA?=
 =?iso-8859-1?Q?MDy/AcYrmim7kT332bYLklHD9f3cHld2Vs6fABnwHtQ0CxIapVI3ZoZHda?=
 =?iso-8859-1?Q?M0Huicru9PNk35IqhQ0z4QYC4tzXO2tZgwqch86fbNxLnzFKqdFIMzHL7J?=
 =?iso-8859-1?Q?mWG+eHdQM7pVZfcCyvxpuvhvs4bpNk8tCcH0moWbZglLehuVXv8XCpxe4U?=
 =?iso-8859-1?Q?+varg+cqz1cJYAfXx9QxZGWorvbb6rwIqC3HM5r8nZkLg7v9YJbg5t+KSw?=
 =?iso-8859-1?Q?HI5wI/Q6dd3+tmggmuSLXj7Ncxz6TUdavTqcqJvnO8wRRrZ5SljiplJUU5?=
 =?iso-8859-1?Q?Y0AlqPID+/hLy7hRHzDNosXMYsRQohY0sRQoducjtrntMc9nrvT3+uACFg?=
 =?iso-8859-1?Q?kSWvu7L8XGi0AyqQB8UEqUBiv2ZwVowe5TY7iag4zrWTf7zWXdDnjFHjjj?=
 =?iso-8859-1?Q?b2NJRFSMpmaqDqK73dlh1qEhMO7d1wsBq7x5BQ1t+mphXJV5BWG+1EUt/Q?=
 =?iso-8859-1?Q?CPZNVPMFOMOkaz7qhMDtbR87Asy1y5v3uv7OH0huXoivoQc81xDEgs+q+2?=
 =?iso-8859-1?Q?dZ6MPeewKqH2CETvuLPwZT4o7SrLuDHIMnIl9KXp6dYJpXVjnl5OGv6EZp?=
 =?iso-8859-1?Q?+cjrCjEjIFDUgX3WKjwCvsraNs4sVe0KGlhOCOfRfqzoWxxOR36RN9dFd9?=
 =?iso-8859-1?Q?MKvkDfcjFlvI5PzMY/nMWYzk9/iyr5KxebOcVz1P1u1PcpsHCxJ9NMhBum?=
 =?iso-8859-1?Q?96X+evAvCj1jLYvPzd+7InhhOxEP6c0GTZuwntP8CpdjV7zAymApWeAtAg?=
 =?iso-8859-1?Q?XEp6Hyhhz43KajVT+gpYc4eJzSOocz5ghWn4GzcB3EOrrc0tz9i8rZJaVO?=
 =?iso-8859-1?Q?bKNunzmDGV8miwJ5iqK0CloTwfTsf0TK5BCLnop/jL5SHwd23FgMh0cLBl?=
 =?iso-8859-1?Q?mMFRz49gPC7HfKPPKXk3zeSgVMVOc+//RiU+nhes03MZStlu6W3R+PD63F?=
 =?iso-8859-1?Q?QICpvrsY6Q2gL5Brt0i232MtW7ckuivzjTVKYNO4b10QuUsQ1uw9+2fwiP?=
 =?iso-8859-1?Q?jYMbmtnJYxBAWzo58jq43LQSG+W8vmKQeEu9bhpbdGl5C2ZsRmB1463UI6?=
 =?iso-8859-1?Q?1ulU1AP/DR4Yo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d57bfed-2025-4fb6-a2ef-08dc40b51aa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2024 03:49:36.0203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wlnD2xZpAkmqkCZQhqtMSizfsDVjYW9KhgCHXgE20XNqryjgsyMvO1lOZ8owkZDsDmFZ7yxP034DsS7twPhVgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982

Bringing this to the fore.=0A=
=0A=
>> Where does that leave us for this patch? We check the VM_MTE_ALLOWED=0A=
>> and check for ZONE_MOVABLE struct pages as one of the conditions for=0A=
>> NORMAL?=0A=
>=0A=
> I think we should keep it as simple as possible and, looking at it=0A=
> again, maybe even ignore vm_page_prot. Two questions though:=0A=
>=0A=
> 1. Does VM_IO imply vm_page_prot never having MT_NORMAL or=0A=
> =A0=A0 MT_NORMAL_TAGGED?=0A=
>=0A=
> 2. Do all I/O ranges (side-effects, non-RAM) mapped into a guest (and=0A=
>=A0=A0 which end up in user_mem_abort()) imply VM_IO?=0A=
>=0A=
> If yes to both, I think something like below would do:=0A=
=0A=
How may we get the answer to these? It seems to be the logical behavior, bu=
t=0A=
how can we confirm?=0A=
=0A=
While we discuss on that, I am considering to send out the next version of =
this=0A=
patch (incorporating the feedbacks on the thread) that is rebased to a comm=
it=0A=
inclusive of the recently applied KVM patch series:=0A=
=0A=
[KVM: arm64: Allow the VM to select DEVICE_* and NORMAL_NC for IO memory]=
=0A=
https://lore.kernel.org/all/20240224150546.368-1-ankita@nvidia.com/=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mte_allowed =3D kvm_vma_mte_allowed(vma);=0A=
>=A0=A0=A0=A0=A0=A0=A0 noncacheable =3D false;=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // or 'device' as in us=
er_mem_abort()=0A=
>=A0=A0=A0=A0=A0=A0=A0 ...=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (vma->flags & VM_IO)=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // replaces !pfn_is_map_memor=
y()=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 noncacheable =3D true;=0A=
>=A0=A0=A0=A0=A0=A0=A0 else if (!mte_allowed && kvm_has_mte())=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 noncaheable =3D true;=0A=
>=A0=A0=A0=A0=A0=A0=A0 ...=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (noncacheable)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 prot |=3D KVM_PGTABLE_PROT_D=
EVICE;=A0=A0=A0=A0=A0=A0=A0 // or the new KVM_PGTABLE_PROT_NC=0A=
>=0A=
> mte_allowed would cover DAX mappings (and, who knows, some future DAX=0A=
> mapping may allow MTE and the driver explicitly set the flag). Anything=
=0A=
> else hot-plugged into ZONE_MOVABLE should have VM_MTE_ALLOWED set or=0A=
> MTE disabled altogether.=0A=
=0A=
--=0A=
Catalin=

