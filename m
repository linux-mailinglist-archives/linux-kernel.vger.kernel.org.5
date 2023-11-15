Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172257EC818
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjKOQEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjKOQEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:04:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272A295
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700064280; x=1731600280;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=O/fZFbklNsKeN7n0YTs1ErGCdGrUFkA8QD9UV8Sn92M=;
  b=Oxy1r0mQdGHqr69zJQrth4RfIyAgFUf9aQxaU9BdO52TrABp6OP9t3Xa
   j6UyQUm08TuxiNw1V6yp6v4JIP+Y4Otf0VQV6OSM5uvhtFtQuQWEKa4zu
   FtialsFMTisCcCjptBihHegKbcVO1yKXEulr6ELmlgzQotRD7uwZfDZVg
   Ntee3ONQflE1kAZLub5QmPDUxXbnEyt35oaN+tl3uAZWWjGFadcLzUS57
   FF9kjxBhqSIsx8P0VNXAjfU4B2ywhOUAvTXqzSRhseL1uNagvXS4ffB2D
   J8cN59nOAD9wz4292U1rONYx0MGZI0dQ7ul4dgTtIWnkB252bmzUcdpx6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="389752763"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="389752763"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 08:04:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="6209924"
Received: from krchrist-mobl2.ger.corp.intel.com (HELO [10.249.254.114]) ([10.249.254.114])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 08:04:36 -0800
Message-ID: <62cdf31f6dbbb3a114755affc89d22fde875c3ff.camel@linux.intel.com>
Subject: Re: [PATCH v4] Documentation/gpu: VM_BIND locking document
From:   Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     intel-xe@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Oak Zeng <oak.zeng@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Francois Dugast <francois.dugast@intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 15 Nov 2023 17:04:33 +0100
In-Reply-To: <ZVTfmbDz1HGqt4Ef@pollux>
References: <20231115124937.6740-1-thomas.hellstrom@linux.intel.com>
         <ZVTfmbDz1HGqt4Ef@pollux>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Danilo,

On Wed, 2023-11-15 at 16:11 +0100, Danilo Krummrich wrote:
> On Wed, Nov 15, 2023 at 01:49:37PM +0100, Thomas Hellstr=C3=B6m wrote:
> > Add the first version of the VM_BIND locking document which is
> > intended to be part of the xe driver upstreaming agreement.
> >=20
> > The document describes and discuss the locking used during exec-
> > functions, evicton and for userptr gpu-vmas. Intention is to be
> > using the
> > same nomenclature as the drm-vm-bind-async.rst.
> >=20

Thanks for reviewing. I'll update the document accordingly except for
the s/an rwsem/a rwsem/g, I think it's "an rwsem" similarly to "an r".

/Thomas

