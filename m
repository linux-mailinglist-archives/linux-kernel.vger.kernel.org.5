Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585987FC2A2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346382AbjK1Pv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346220AbjK1Pv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:51:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD5790;
        Tue, 28 Nov 2023 07:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701186723; x=1732722723;
  h=message-id:subject:from:to:cc:in-reply-to:references:
   content-transfer-encoding:mime-version:date;
  bh=G6WuKwckF5V3NRC/1N7CGXl15yQ58N1giIylX483ywI=;
  b=C3e341XCyrYHEtGowdrHkyYfnNf6eMxjH7b3chqjHiRDd5ozaVWexk7C
   vY0VZJ8qXTCdfkDCdoFuytaWZzEBvREbZ08JBFm5q+UvLj24uDRD2gNuf
   yhva0NNnRSWCeNvN1EagP2249FOyL7JVH8BltesWQ64mk3MKHMLEDLts8
   MT7qpozJJDNsXYjLM6XCzPmPuSpMkuiAXu9iiNNfoyBDQoqIAiwRkb3ff
   p+0pD9RBrt7k6770hKJwlK6cLmTuG2ipM3JaTp5Or1jRZNI9UNEGzt8F0
   CvJKHV4YngTZf7YetucSxUCSlcw9KmWOkJyN3LiuwXy29PdJMkvkKw9Y/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="372323268"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="372323268"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 07:51:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="802983212"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="802983212"
Received: from lapeders-mobl1.ger.corp.intel.com (HELO [10.249.254.81]) ([10.249.254.81])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 07:51:49 -0800
Message-ID: <03712311650b5fcf7162309f13a18dbd240e8a9f.camel@linux.intel.com>
Subject: Re: [Intel-xe] [PATCH v5] Documentation/gpu: VM_BIND locking
 document
From:   Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     intel-xe@lists.freedesktop.org,
        Francois Dugast <francois.dugast@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Danilo Krummrich <dakr@redhat.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
In-Reply-To: <ZWTvohD9rTx9aAWa@intel.com>
References: <20231121104046.3201-1-thomas.hellstrom@linux.intel.com>
         <ZWTvohD9rTx9aAWa@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Tue, 28 Nov 2023 16:51:25 +0100
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-11-27 at 14:36 -0500, Rodrigo Vivi wrote:
> On Tue, Nov 21, 2023 at 11:40:46AM +0100, Thomas Hellstr=C3=B6m wrote:
> > Add the first version of the VM_BIND locking document which is
> > intended to be part of the xe driver upstreaming agreement.
> >=20
> > The document describes and discuss the locking used during exec-
> > functions, evicton and for userptr gpu-vmas. Intention is to be
> > using the
> > same nomenclature as the drm-vm-bind-async.rst.
> >=20
> > v2:
> > - s/gvm/gpu_vm/g (Rodrigo Vivi)
> > - Clarify the userptr seqlock with a pointer to mm/mmu_notifier.c
> > =C2=A0 (Rodrigo Vivi)
> > - Adjust commit message accordingly.
> > - Add SPDX license header.
> >=20
> > v3:
> > - Large update to align with the drm_gpuvm manager locking
> > - Add "Efficient userptr gpu_vma exec function iteration" section
> > - Add "Locking at bind- and unbind time" section.
> >=20
> > v4:
> > - Fix tabs vs space errors by untabifying (Rodrigo Vivi)
> > - Minor style fixes and typos (Rodrigo Vivi)
> > - Clarify situations where stale GPU mappings are occurring and how
> > =C2=A0 access through these mappings are blocked. (Rodrigo Vivi)
> > - Insert into the toctree in implementation_guidelines.rst
> >=20
> > v5:
> > - Add a section about recoverable page-faults.
> > - Use local references to other documentation where possible
> > =C2=A0 (Bagas Sanjaya)
> > - General documentation fixes and typos (Danilo Krummrich and
> > =C2=A0 Boris Brezillon)
> > - Improve the documentation around locks that need to be grabbed
> > from the
> > =C2=A0 dm-fence critical section (Boris Brezillon)
> > - Add more references to the DRM GPUVM helpers (Danilo Krummrich
> > and
> > =C2=A0 Boriz Brezillon)
> > - Update the rfc/xe.rst document.
> >=20
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
>=20
> First of all, with Bagas and Boris latest suggestions, already few
> free to use:
>=20
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
>=20
> But a few minor comments below. Mostly trying to address Boris
> feeling
> of long sentences. However, take them with a grain of salt since I'm
> not
> a native english speaker. :)=20

Hi, Rodrigo.

Thanks for the reviewing. I've added most but not all of the
suggestions in v6. Regarding the comment about "zapping", that's used
by the core mm for the process of unmapping page-table entries;
zap_vma_ptes() etc. Merely following that, although I'm not really
against using unmapping etc.

/Thomas

