Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C149769F73
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjGaRZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjGaRZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:25:46 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFEB99;
        Mon, 31 Jul 2023 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690824344; x=1722360344;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=tOaiU4cEgXx33j1eFFwU96iW7cyeqreNI8HyxGMw5FM=;
  b=G7oW17v0DaEAJMAAwnTfQ1dNA4qaTEQCaf29njylolosom6QvcX1Y16u
   nKvlRuC6O/zkmcRNiw9nvF5yuIy0psnPPUKNOy/nQGdOGygEZ2THVlRvE
   CgCipkXxkh72gzB8cBgZg//Ln0wBc2yO4fb/brVf6fwkHrN+qg5ZHAxrT
   /q5yhrX09s1tcTjSfltiiYyS5m9mGGp/WrSSaUQVmM9LtYVZKhOM1vSSc
   CXqs3fjR4UNhGyIGmaV9Jtutkma1VvVsuH7XrlHkaKF++utTWCc1by6tR
   5nJ2VXoRBWWYf0natFqDucAvT5xw6XlHz9bT+CtF5O+cdNJ0LZiKBKp4+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="366559510"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="366559510"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 10:25:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="731662544"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="731662544"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 31 Jul 2023 10:25:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 10:25:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 10:25:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 10:25:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 10:25:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpO4cNOduuhnZ53AyUZIP9KPDxqZB/WgeeMjlqw0RDoKOVlb1MW7vVkhfxr8TJt0YrGutPonfWR+bYcNCHUNtFTs8KzTTHfzKx7IZomWXf0mzD6c9zve8hJjoDUl1QvUDNbgbskHzAwhIa/U8Yp+zwN1viJnJ5t0YH3APNlc84TpJ7MD7LtA7O3A6+97qKcANbhFy/j488TOpOA8Ng/qHfj742gyh5RjbTaMvOyT4X2Q1alc34USmPNLP+VS43z/i9Lm4YJRk2NjF4mRmKaLjj/tF3ItVgNTb7w3OAQVSC0OpZUNOFUHOZTh/q7cA2hC5Ndlrxha24NX9FfBNiPXLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8U7uYNFyqEm2rr/nJcH8jgoLZNRGfvT+YsaRge2b8g=;
 b=i46+j5Q+XaGM8ZTGDasQklCFcm5q9bZIYNc3VJX+ZG2wkwtM+D3w80n/tsVZtQw0tvsxFo59FSgqUcPDJ5LmIIaZ99TCRdt/jchOO4qbNnh59UbvYTgvINh1D6iUphw0DtfFO1a02QxBUPnqDZ5Ne1EuhKudzdZjWvm5LKac8c0lbTNdvOo1mpCgY7++neO4zuS0YG/8mDxG2rbg4D9vwPQQmIYtVsmM5HnR6f1m8lF8u0xtwN2cJg+8mVtk/wI5BKa4pI26CYjId8jxRexxQti72/zcJeaSyZbyK/BSvdpjvDnEHaprS9P5FobyKz5q3MJQ/nahHzTdmWHpuz7gFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6924.namprd11.prod.outlook.com (2603:10b6:806:2ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 17:25:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 17:25:00 +0000
Date:   Mon, 31 Jul 2023 10:24:56 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dan Williams <dan.j.williams@intel.com>, <dhowells@redhat.com>
CC:     Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Dionna Amalie Glaze" <dionnaglaze@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Message-ID: <64c7ee68b56d8_51ad029422@dwillia2-xfh.jf.intel.com.notmuch>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
 <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
 <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
X-ClientProxiedBy: MW4PR04CA0366.namprd04.prod.outlook.com
 (2603:10b6:303:81::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: a0fafacf-902b-4f41-697f-08db91eb119f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zBHrs2NznjcVZ++pQqR0g+6Bp2SeCC1XRqGMdbvl0w9Wuk43ZWVDlpcsL/1DDK14Tr9RALviu4iJNP79nj/ywILY6ak64laBWIN17FodWZDzJVOWlA2pw8HsSzN/1PQXLBQHa1Z0lrPO+dbR1iv3BleAIIGqI5vBtNZ6MVKW0Vf3XG2QWUEkHAOWEHEQMz8raxvFH4Bf4hxbb/YK5+pfwuwRrbi+CT3XJMI4X74Nns9HaH36QkJlPX/gfF0WwNNHW5Ie4u4yZYEdJ71TlX3pEbKrfmE9fqhTmuB6IXFoK68TMnYGSYqTwrW8YDtS6KbBQOxGpAlY2E4RUqnHE9zom4rCgId81nrJsX0rXFxkW4U/qTgJR/eJGR48XU56yas9jrG8kJ0VrdpGaAh9uPnJefGM/vj6vv3RAMcwXGohcMKrHSP5kWIcq6jaWSndan3CcVvcy5v6QqUHB2sUhXXBPQAxkb8d9m+fNV0Ij+OAjUEAbpZaoM5vaxWAM7EAPLLKGEx3AoSopB8z4GHLzR886q04gm8jrofPiNJpt2Xka5zNUa0fUNUPxUA5O1w5Hrb/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(38100700002)(66476007)(86362001)(8676002)(8936002)(316002)(4326008)(5660300002)(54906003)(7416002)(41300700001)(66556008)(66946007)(82960400001)(110136005)(478600001)(2906002)(6666004)(6512007)(9686003)(6486002)(6506007)(26005)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9FWG5fljcnWd/KUYgLDA0NZnMRsRV/svjMRdEufTm9xKIA+EWZ8Zm4pbgI?=
 =?iso-8859-1?Q?jPTWK5Ip4TvR17DdlgQXQdy+qLxC5UBoZNI9RLMl4qMT6agMcTnrV9Sb7z?=
 =?iso-8859-1?Q?eGw5892kd4fXLMxKD1XzLAK9As13urrrZvR9yfXc9zA1ihF/S74SxWOKiX?=
 =?iso-8859-1?Q?qh/3iMnwiZwJBgfuTQbQOnNy3Bek3+fAnyGBvySdHv4EhB/LUkPC1kgul3?=
 =?iso-8859-1?Q?dMlD9FQGjDtXQl9twX+wE0tuAMukruGeC7BrQc/7ntFbNP2rScftyjA0oI?=
 =?iso-8859-1?Q?Mcnoq07YdcXABABfpK2o3HLkGhOqU/F5gzs47YfDPO4Xq3rPJ/wVDMcm60?=
 =?iso-8859-1?Q?X/EvOvVxIWOgYXiONbAn8kjPIfv665BuW2YJpoFOwVaMzC/ZxBndyix0xq?=
 =?iso-8859-1?Q?s24we0Z1flku84ypQwDd4eMefbz7izHsqfV8c/diPhlYcrtX1RoLFzs2Nz?=
 =?iso-8859-1?Q?KADpg4M6p89RAiT5OUDbiRgYjNo4R3Pv+11RSEimcRaYYNksOz8Ejq5YjQ?=
 =?iso-8859-1?Q?sHpTVwPce186R+BxLqMJdMEBE8a2Imukl3dBd2hsJhnvZOY6xRANkR41+B?=
 =?iso-8859-1?Q?onxkKPFMP/S39DD4s9f+W35bl9jz10SWNOa5Yilj5EkrVPFcc06NIEJelB?=
 =?iso-8859-1?Q?RYFEiPBEEd9UGoSdIidTcW1Ke00unGStfYILN/fF2hR1SDQwf3nIABGDpg?=
 =?iso-8859-1?Q?azcPM1WSU3SZij45z7yRrOo0Xf1rPtuzdXpud/reKHYjmESHF+mWCyQioO?=
 =?iso-8859-1?Q?5+MPJSKyGwPhrcRywLJHh8vIH3B+D8u4wzkdOhtrPw/5sJi8o0Z8ckSSje?=
 =?iso-8859-1?Q?hn0pMhjH+dr9oPOXGBTfa2bT/OfL+Np0NBNrADQin0oiDN69mSyQzWkYrs?=
 =?iso-8859-1?Q?abJnQJBguJdCdi863zlrZ5whVBi0Qiu7CsPZxWxurQ2hxkK1oxbvDSYigD?=
 =?iso-8859-1?Q?GXUC+W4YGQnt9w56BqsL1sjkVK+lwSgi4z8YzlTg4OguxJe9ElIdeOnUfG?=
 =?iso-8859-1?Q?2FVITNcyqn9WIzAkdzkzgAJl4XUdUiaGTp1g8LRR+3T6ULGKYbWRTsD6CJ?=
 =?iso-8859-1?Q?f/w4DfbH9DouzGxiMooh+qdHPJ4DIxUj/SXrx2k9zvi2PcRLl9lrgwvHBg?=
 =?iso-8859-1?Q?Yh+fz2xjfn7N7vQcZ7C2OyROs4OwH27w3YHPFDfVeP38qBYX2iZ0H7ppvt?=
 =?iso-8859-1?Q?u1s1B49C4pXatMwd626oOYQapszbMc0nRku3CrQGj0NPUFHCGyvjQ7GiKv?=
 =?iso-8859-1?Q?wYQBBfGymXC82pE+qGmhWrdS9lLIoOnjL1DS48KLU4mfaTRz/t1ooS4uAg?=
 =?iso-8859-1?Q?ipPzUOTX59sTv0X4k0QSzDH+BzYfn8VjsQM4r/3KeqZkTYQ2tIH/Vc2VfQ?=
 =?iso-8859-1?Q?c+StKYcLICj999p22KJkNTWAXKHbNJf316Glqs+Cc0JdBkISQ/fu2BPPLp?=
 =?iso-8859-1?Q?IYtamIGQ/xoZ7EA/w0wJTbP+XXMT2gxOarkbpT90pKbPPrE/SwjvkM05wv?=
 =?iso-8859-1?Q?NvhbM1AMKgJhllYsoaMBT//WTX85zLqcz63INEMZ7WF2o/mj51u3Nbc1Zt?=
 =?iso-8859-1?Q?NtD/eB/tUGYVK58hHpNzkqC67p7QvEpXGu0da2091/SDE26VVZIEegvG9r?=
 =?iso-8859-1?Q?ynbEma4Y3HnhboBUxOuaPgcAqhRbo+tyfOPtkv1oUglcrulyPh9a901w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fafacf-902b-4f41-697f-08db91eb119f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 17:25:00.3756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/WSjdxhwDvah3BSBStQQ3rdNMMj/9L0YAZngjYn+EZRlwO4BxY6/OaeBBtubpjqSF82kzAtnylB0VBY+o8gxDRRy4XGP3zfLRk2LlzUeM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6924
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Sat, 2023-07-29 at 21:56 -0700, Dan Williams wrote:
> > James Bottomley wrote:
> > > On Fri, 2023-07-28 at 12:30 -0700, Dan Williams wrote:
> > > > The bulk of the justification for this patch kit is in "[PATCH
> > > > 1/4] keys: Introduce tsm keys". The short summary is that the
> > > > current approach of adding new char devs and new ioctls, for what
> > > > amounts to the same functionality with minor formatting
> > > > differences across vendors, is untenable. Common concepts and the
> > > > community benefit from common infrastructure.
> > > 
> > > I agree with this, but ...
> > > 
> > > > Use Keys to build common infrastructure for confidential
> > > > computing attestation report blobs, convert sevguest to use it
> > > > (leaving the deprecation question alone for now), and pave the
> > > > way for tdx-guest and the eventual risc-v equivalent to use it in
> > > > lieu of new ioctls.
> > > > 
> > > > The sevguest conversion is only compile-tested.
> > > > 
> > > > This submission is To:David since he needs to sign-off on the
> > > > idea of a new Keys type, the rest is up to the confidential-
> > > > computing driver maintainers to adopt.
> > > 
> > > So why is this a keys subsystem thing?  The keys in question cannot
> > > be used to do any key operations.  It looks like a transport layer
> > > for attestation reports rather than anything key like.
> > 
> > Yes, it has ended up as just a transport layer.
> > 
> > > To give an analogy with the TPM: We do have a TPM interface to keys
> > > because it can be used for things like sealing (TPM stores a
> > > symmetric key) and even asymmetric operations (although TPM key
> > > support for that in 1.2 was just removed).  However, in direct
> > > analogy with confidential computing: the TPM does have an
> > > attestation interface: TPM2_Quote and TPM2_Certify (among others)
> > > which is deliberately *not* wired in to the keys subsystem because
> > > the outputs are intended for external verifiers.
> > > 
> > > If the goal is to unify the interface for transporting attestation
> > > reports, why not pull the attestation ioctls out of sevguest into
> > > something common?
> > 
> > That's fair. I originally started out with a draft trusted-keys
> > implementation, but abandoned it because that really wants a vTPM
> > backend. There is no kernel consumer for attestation reports like
> > other key blobs, so that leaves either a key-type that is just a
> > transport layer or a new ABI.
> >  
> > I have a personal distaste for ioctls and the presence of user-
> > defined blobs in the Keyring subsystem made me think "why not just
> > have a key-type to convey the per-TSM attestation reports". Is that a
> > fair observation?
> 
> The trouble with this argument is that it's an argument for every new
> ioctl becoming a key type.  

Yeah, that's a danger, I don't want Linux keyring to become the blob
transporter subsystem.

While this usage is "security" adjacent the precedent is not a great
one.

> We have a ton of interfaces for transporting information across the
> kernel to user boundary: sysfs, filesystem, configfs, debugfs, etc ...
> although to be fair the fashionably acceptable one does seem to change
> each year.  Since there's nothing really transactional about this,
> what about a simple sysfs one?  You echo in the nonce to a binary
> attribute and cat the report.  Any additional stuff, like the cert
> chain, can appear as additional attributes?

That should be straightforward to mock up and it keeps the property I
like of common ABI with optional per-TSM modifiers.

> > An ioctl interface would make sense for a common report format, but
> > the presence of per-TSM options and per-TSM format modifiers (like
> > SEV privilege level and "extended" attestation reports) attracted me
> > to the ability to just have "options" specified at report
> > instantiation time.
> 
> The "extended" report is nothing but a way of getting the signing key
> cert chain.  It's really just a glorified caching mechanism to relieve
> the relying party from the job of doing the lookup themselves.
> 
> > I.e. like the options specified to trusted-key instantiation.
> > 
> > > I also don't see in your interface where the nonce goes?  Most
> > > attestation reports combine the report output with a user supplied
> > > nonce which gets added to the report signature to defend against
> > > replay.
> > 
> > The user supplied data is another argument to instantiate the report
> > blob. The instantiation format is:
> > 
> >     auth <ascii hex blob user data> [options]
> > 
> > ...for example:
> > 
> >     # dd if=/dev/urandom of=pubkey bs=1 count=64
> >     # keyctl add tsm tsm_test "auth $(xxd -p -c 0 < pubkey)
> > privlevel=2" @u
> > 
> > > Finally, I can see the logic in using this to do key release,
> > > because the external relying entity usually wishes to transport
> > > secrets into the enclave, but the currently developing use case for
> > > that seems to be to use a confidential guest vTPM because then we
> > > can use the existing TPM disk key interfaces.  Inventing something
> > > completely new isn't going to fly because all consumers have to be
> > > updated to use it (even though keys is a common interface, using
> > > key payloads isn't ... plus the systemd TPM disk encryption key
> > > doesn't even use kernel keys, it unwraps in userspace).
> > 
> > I do think the eventual vTPM enabling is separate from this and I
> > mention that in the changelogs.
> 
> vTPM requires no enabling: it will just work with the existing trusted
> key interface.

Oh, I had not seen a TSM implemenetation that presented an TPM
API-interface so I had been thining one had to be built around
facilities like derived keys. I agree the best vTPM is just a TPM.

> >  That functionality like SNP_GET_DERIVED_KEY is amenable to a
> > trusted-keys frontend and being unified with existing TPM paths.
> 
> To get a bit off topic, I'm not sure derived keys are much use.  The
> problem is in SNP that by the time the PSP does the derivation, the key
> is both tied to the physical system and derived from a measurement too
> general to differentiate between VM images (so one VM could read
> another VMs stored secrets).
> 
> > 
> > This report interface on the other hand just needs a single ABI to
> > retrieve all these vendor formats (until industry standardization
> > steps in) and it needs to be flexible (within reason) for all the
> > TSM-specific options to be conveyed. I do not trust my ioctl ABI
> > minefield avoidance skills to get that right. Key blob instantiation
> > feels up to the task.
> 
> To repeat: there's nothing keylike about it.
> 
> If you think that the keyctl mechanism for transporting information
> across the kernel boundary should be generalised and presented as an
> alternative to our fashion of the year interface for this, then that's
> what you should do (and, I'm afraid to add, cc all the other
> opinionated people who've also produced the flavour of the year
> interfaces).  Sneaking it in as a one-off is the wrong way to proceed
> on something like this.

Fair enough, I'll take a look at the sysfs conversion and we can go from
there.
