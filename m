Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E014782BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbjHUO0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjHUO0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:26:33 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8320CE4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:26:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsVRJ2Y5+u+0kmMfcBx068LypdYSOs190RdAFoKfNyz3dQCzngoJUOUDGLTadP95IKHEWxi0GAw1uIWBMqwIJ728hXnqct2HSX6Dh2HjGN8pY8GGt+AKXNc6pISyCDkgZqAQ1yfrQxDmtwEb8S6Pn+V4QAtMmOumtJZzZ0lJTo1ehm5lMe34+a3G492U6b/TALyScNWdFiy4A6bZ+mg9cO3v+q5wkfPgys5FtFvyWuNaF5wRMISMP0Yt/pjbQetF1AwSFW5KrDd3Li9cq5+NKC+2dBXbFXHNoElrwLsqBBukBnYqwu1pMms2gLCd3MgSx/IkPZS5/7vX9UvWSkjBEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4xk5kk2YwWKd/cnrmpXzM65kinrEyFD+IQw7mfyBjE=;
 b=n8aFGtz2Xigd3aL0HOmHRwX2U4vHfueIvTuLDa69fogR7y+9q0ekSvNpz7NDuiXZuV5PxsTmZRbWcZMAqDbETUloKpG3pt7sy9itTOqLq0hNhOdCnEDJvmzuRBaeNatZxUz4xx7QcyrlrLdYkK5YV4hi88700noWtQayGuYtF1Eje8zfaT1mAtXmd+Hesyv38MxI8s5bAfmK51K1VDMZSYCqs8IFaaYVDFhaecW83OIMJhuSJa5xqVSih93OGbSaJ/mQJCETX2WcDg0ArtilGr3zOivlCaETTBu/b9VJUn1X+sCbOfvHEnUXo/WprqgNDuRcJEsmP18MDUagt7l59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4xk5kk2YwWKd/cnrmpXzM65kinrEyFD+IQw7mfyBjE=;
 b=qAOm79DJCU5yJivMVcDypmnFrf9Ed7c9c1uuU3COlOGOew3eFmHk8bs/epz9h3Igfl3/sfeSrFHqWAH+/bYgJ6gSsHvRR8AIODujyC89FHf2X0RSLPJE5lK9xhNnIn5bl79fVpWK4Erpw5WSfGdbWMXfMallMVvt3eJiZcuNmnWD+1S5t9ju/B2L2UkyxMExUVteEPzWq7v3mN8J3vkcK0WZgpJUxDN99LQZfeUCvDiePa1PfSoIbwQYlnoW0XxTW5d1321/D9V2qll7bOhoC1BkcoVGYZ8hxdDuoGyvEzYsvBPVLo5YBalptawiLZT7RDnoBAcvSXvKz2bOPEmUmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 14:26:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 14:26:29 +0000
Date:   Mon, 21 Aug 2023 11:26:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org,
        robin.murphy@arm.com
Subject: Re: [RFC PATCH v1 3/8] iommu/arm-smmu-v3-sva: Allocate new ASID from
 installed_smmus
Message-ID: <ZON0E3KV46EEPw/p@nvidia.com>
References: <20230817182055.1770180-1-mshavit@google.com>
 <20230818021629.RFC.v1.3.I326c62dc062aed8d901d319aa665dbe983c7904c@changeid>
 <ZN5pK03Drao/egeF@nvidia.com>
 <CAKHBV27k8F0ZLy=RA=WhjJ7+C9JMHRRnKs=4W4pJMNmxrMEXxw@mail.gmail.com>
 <ZONQgNh6qarqgA+f@nvidia.com>
 <CAKHBV26oTZLssq5bopePojqgrEJwukKHYEbhU02nAvHHVB13mw@mail.gmail.com>
 <ZONrkVX6kZjX/wus@nvidia.com>
 <CAKHBV27PL=2jxOd0BoYdoBMTu_0rm4z_JP6iG+SVi5Ag7w2kWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV27PL=2jxOd0BoYdoBMTu_0rm4z_JP6iG+SVi5Ag7w2kWw@mail.gmail.com>
X-ClientProxiedBy: BL1P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a1e8e3-8f55-42f9-aa9a-08dba2529bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvjmjkyPZT7y8FlN16qGN6OT6HIsT8fMKtw9kq6P1pNzleOoqjzA5QK3AR+LXZBoAOc4QxWZmQBDaYQaTK/NaPqnCTVn0P5O4H6cWzsLoaD6dXzHj4Z6P7fVsNfCgA2z3O+ajrQ5iUvygtdl/Ls3an7Ouh75SAsbJyRwStW0/BgDByP3iDubWanZDgkHg674G4MuNt9R+JVKvZD3svFz8iHWpporK6atwxIAtTJuW2dsP+nNtgMpvOzKCCzlvzRvWlzpWtHx1cfCncFJSISn3Ew7FvJW47dhaCkA+IcflnRBrpQkO0fdDc5fXvc4pHo7hXN9/p5uLup8Y+G8HlQa/MkTd33/3Wy/TMDdt9mxMMcuqjkGgEEAhuhNlO6H9YF1/CSTg2d7B4ToS0VI4CJAo8Ap/hykkS9iTmQWzB2YhxnKlw+hhfCRTtzy+fBKXVFA6eAJvTIRWrI1i9vBQKa1Lcfrbp9DrAGD9WoE/VSupYI8uj08/j9xBwGTc/WSnIXrt0YzCM8tI1B6xBRZNmBW1ewGuqINYWUjJLa8BX315NPEKyXACQbgjXdgGuniwSOL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(53546011)(38100700002)(6506007)(6486002)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmE4WW9IemdDU01GS3ZNV0xtZXk3c2Z4akgxWUllMzRtbkFkQlBlNmoybGUx?=
 =?utf-8?B?cmI0TjU5a0ZKcmYvVldpaVBqQ1R1OC9MVHBZVHUrV2NJY2tUSGFzb1JpeDhH?=
 =?utf-8?B?M3hBdEk4VXU4NG9HeU1vb0N0ajdKNUVDcE9zVEtYcTNSeEdxZnNtaEFRcnZx?=
 =?utf-8?B?akhuU1pobkJXM04wdy9zUjJNVXNsNFBCTFhROU5vSUF0WXBTTlRiSmRGcFpn?=
 =?utf-8?B?ZWpsdWYzMWZqNVVrRTNuWUpZUHpqcHQ4SW8wb1ZJeGRLZUI0Q2pUa0hKWGhW?=
 =?utf-8?B?NVQrSFhrbjJ1cHJGSGpYR2s4NXpReW5oZnk0c2NOUmtxOHBGRHhBL0JjcENZ?=
 =?utf-8?B?Nk9MZy9XdUlydThhcEdRL2VjcGFmZEF5cEpwVmx0aVVjVm5JUjRsbmRXai9Q?=
 =?utf-8?B?Y082ekVDdzcxaEt4azU3ajF2N2hxV1hYWktFN1NabEZQVVpMbi9mRDFmZEt6?=
 =?utf-8?B?T0JRNFJIeWdISWVqTEp3R3FiM1dtdkU4dFpjSU84blBkNW10bllFaVBxTzI0?=
 =?utf-8?B?UFIzT1MzTFpNczFqY1NmOG9ZQTlQWW95dnA4SGhtSUdNVDA5MWt1am8xcE05?=
 =?utf-8?B?Y0UyRHJFSGNLR2J5aHB3WlM3Vk9DOFFFcGR6d2pvcGI3b2NUdWtHQ3dXbWV5?=
 =?utf-8?B?OWM0bG4zSTdHSyt1S21XcG85YitMZ3hleUZlQnBFdDVFSUhMaC9FUlV3NVVP?=
 =?utf-8?B?MXpHamovRWZFb2FmVENmanpHRnl3Y0J3dGx5Sm1NQ3dsTXpiOHFrU1Q0MnMy?=
 =?utf-8?B?eXVzK1lsajZrMlZ4c29Bb0k4Zm1NeTl2T2d3Y0M1Q1lhUFBIaXFPNHNJdDFK?=
 =?utf-8?B?V0g0TkxDaDR5Z2FuaGRXazhEa25ia3VYc2tKbGRxSkdlaW5Nayt3V2VVak9W?=
 =?utf-8?B?NFdMb2JPQXpUcmYwU1FLdnJPa2ZGZERiZU9oOE01T0VRT1AyOG92RGlOcEpI?=
 =?utf-8?B?dVRvdjVNK0VrSXdDd3dPeGQzVFk3U0c4a1JOcWF6UTM2dldrN1FjRFRzMjZ0?=
 =?utf-8?B?NHAweUpVNHFQVDJlYjE4QzlsL2piell5KzVXVG5KQzJOM0orczZlNjhwczE4?=
 =?utf-8?B?cGdjbk4rbjVMb2crVFRNdkh3bnNDZlh0MDFFdFBCVVZJc2N3R3V3ZjFWNWQ1?=
 =?utf-8?B?SWN4enBqRWlQWU5lSFBQdnBtM0JOc2RiQklPVnVyNngvWitmVlZQODFxME1V?=
 =?utf-8?B?VEhXbGROUEdIaVdnRUVDMEdZdGUvQjVCdjdnL0ZlOTlnZUI0a29hQVNmYkI1?=
 =?utf-8?B?ZzQ3M2p4RHBWWG9rR1NtS2ZuRXd2Q0JIakNMWmczYUxzUXNDKzJXSkRTeFAz?=
 =?utf-8?B?aHJUcldEOUtndG5obTJTNDdCNHBjUW9iemd0SFBpdEZTYnNMS1c5NjRXU3NO?=
 =?utf-8?B?MzJvQmI5Uk1FZVZJcGU5aHEvMzdIVTNPaTVoWHJhUElCaXhVSk5LbjJRZEVk?=
 =?utf-8?B?TGQvT0hnZjcrWVVBTWsrbGNDVDBQaVVSelR3Q0RlUzBNUDVwQVBENGFhRXox?=
 =?utf-8?B?V1FYSTlTK3J1MG85YVhxaWFkc2Y4S0pQMUVORHprZ3hZQ2Y4T0djOG1mbk1F?=
 =?utf-8?B?dUlsS3VOSXdTS0E3c2cxeFJnVDVIcTE3SmpuN2FGVGJ0WCtONzFQZEh4bjJy?=
 =?utf-8?B?dDR5R01PZ3FjTE43NUZFelNSQjJoNUJMRDhRRlJWVXo2cS9kdGZCaWp5WVJJ?=
 =?utf-8?B?b3ZPeUYzb3JwZzhHRFV2SFVzUzUzSkRXSVJpc3dsellMYUw3eWd5alN0QTNy?=
 =?utf-8?B?OXRvUVhXTGgyVW12SjlDeCsvZzlRdlpLV3R2Z1VYTSsyZVNMOG9sYk9GZ2kz?=
 =?utf-8?B?U1hJci9kdE5qRVd0elhrUncrMXZDcmFQNEJWMGF6VlpMcnFWZTc0SUdCaWVR?=
 =?utf-8?B?dEdUMFdjT3UzdytIZEpCS1VodmFDSU5JWVdZY0R1SUNiNitlWEJiQlQvYSs5?=
 =?utf-8?B?Ky94cGJlK3N2dlYxNVNZM1JQZHlOM0dtRGxBaU5KU2tkdHBvR2IvREo4ZEVp?=
 =?utf-8?B?bFpwTEwrYXNtLy9NUm1haDVrdFNQVFVLeEZGWVN1WTFRTkV6TVFpQnFIbi9J?=
 =?utf-8?B?T0t5dHhLdldLV3ZBZGdSdTl2VTMrSDBrVlVJRFQrSFBZZCtwWlZod2ZNWDNP?=
 =?utf-8?Q?Z7g65cmq1/IZ2bcREE3aszh2/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a1e8e3-8f55-42f9-aa9a-08dba2529bcd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 14:26:28.9767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXn21Zd93kplklbVw/To4p6Vf+KxzrSUbmmEmjq09+L9SAABMcLc3MLc/xn9GGoK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:16:54PM +0800, Michael Shavit wrote:
> On Mon, Aug 21, 2023 at 9:50 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Mon, Aug 21, 2023 at 09:38:40PM +0800, Michael Shavit wrote:
> > > On Mon, Aug 21, 2023 at 7:54 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >
> > > > On Mon, Aug 21, 2023 at 05:31:23PM +0800, Michael Shavit wrote:
> > > > > On Fri, Aug 18, 2023 at 2:38 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > > > >
> > > > > > On Fri, Aug 18, 2023 at 02:16:25AM +0800, Michael Shavit wrote:
> > > > > > > Pick an ASID that is within the supported range of all SMMUs that the
> > > > > > > domain is installed to.
> > > > > > >
> > > > > > > Signed-off-by: Michael Shavit <mshavit@google.com>
> > > > > > > ---
> > > > > >
> > > > > > This seems like a pretty niche scenario, maybe we should just keep a
> > > > > > global for the max ASID?
> > > > > >
> > > > > > Otherwise we need a code to change the ASID, even for non-SVA domains,
> > > > > > when the domain is installed in different devices if the current ASID
> > > > > > is over the instance max..
> > > > >
> > > > > This RFC took the other easy way out for this problem by rejecting
> > > > > attaching a domain if its currently assigned ASID/VMID
> > > > > is out of range when attaching to a new SMMU. But I'm not sure
> > > > > which of the two options is the right trade-off.
> > > > > Especially if we move VMID to a global allocator (which I plan to add
> > > > > for v2), setting a global maximum for VMID of 256 sounds small.
> > > >
> > > > IMHO the simplest and best thing is to make both vmid and asid as
> > > > local allocators. Then alot of these problems disappear
> > >
> > > Well that does sound like the most flexible, but IMO quite a lot more
> > > complicated.
> > >
> > > I'll post a v2 RFC that removes the `iommu/arm-smmu-v3: Add list of
> > > installed_smmus` patch and uses a flat master list in smmu_domain as
> > > suggested by Robin, for comparison with the v1. But at a glance using a
> > > local allocator would require:
> >
> > > 1. Keeping that patch so we can track the asid/vmid for a domain on a
> > > per smmu instance
> >
> > You'd have to store the cache tag in the per-master struct on that
> > list and take it out of the domain struct.
> >
> > Ie the list of attached masters contains the per-master cache tag
> > instead of a global cache tag.
> >
> > The only place you need the cache tag is when iterating over the list
> > of masters, so it is OK.
> >
> > If the list of masters is sorted by smmu then the first master of each
> > smmu can be used to perform the cache tag invalidation, then the rest
> > of the list is the ATC invalidation.
> >
> > The looping code will be a bit ugly.
> 
> I suppose that could work.... but I'm worried it's gonna be messy,
> especially if we think about how the PASID feature would interact.
> With PASID, there could be multiple domains attached to a master. So
> we won't be able to store a single cache tag/asid for the currently
> attached domain on the arm_smmu_master. 

I wasn't suggesting to store it in the arm_smmu_master, I was
suggesting to store it in the same place you store the per-master
PASID.

eg I expect that on attach the domain will allocate new memory to
store the pasid/cache tag/master/domain and thread that memory on a
list of attached masters.

> > > (on a loop over every smmu the domain in arm_smmu_mmu_notifier_get is
> > > attached to, which just at a glance looks headache inducing because of
> > > sva's piggybacking on the rid domain.)
> >
> > Not every smmu, just the one you are *currently* attaching to. We
> > don't care if the *other* smmu's have different ASIDs, maybe they are
> > not using BTM, or won't use SVA.
> 
> I mean because the domain in arm_smmu_mmu_notifier_get is the RID
> domain (not the SVA domain, same issue we discussed in previous
> thread) , which can be attached to multiple SMMUs.

Oh that is totally nonsensical. I expect you will need to fix that
sooner than later. Once the CD table is moved and there is a proper
way to track the PASID it should not be needed. It shouldn't fall into
the decision making about where to put the ASID xarray.

Jason

