Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDBE7EC98B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjKORTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKORTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:19:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F60BB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700068754; x=1731604754;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wx2SPvBGnpmVTAWmi/aj6F1855YCm7c7ct3xuZhFHrU=;
  b=GFFO4WzbwL4gGSdBiW7KtJOedV1UHtatR70wzolQ8Yp2I61WcgaNSRkX
   LvZ8BhWVGTZPdFGoskv0VETqbuVdLSLA+Miztzy/Sdi8INY+sYg4QKEQ/
   qf/mihgWaZsAK2zFwXtFCEyXIQaWK5BDclMthaYexyOotxUoPlQqHkGRw
   EVxZhypykPIisdHaWTiRh08PeVVR/X4Px0iC9fG7OuQ33fimBVXUZlZDM
   SDLXNVazweXm51u4+Qwp1VJDpLQ4MP5xiLpqR/D1bv37T/FrWBszSoxEO
   nCWQEp+5Y3JVuBlHcWrzVUiI4gVGuzp/mfMSs3GCnDkm9TjE/C1ZTzmVz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="393768721"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="393768721"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 09:19:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="794213200"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="794213200"
Received: from lapeders-mobl1.ger.corp.intel.com (HELO [10.249.254.116]) ([10.249.254.116])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 09:19:08 -0800
Message-ID: <3c4b2eea-6292-a82e-d862-98cf1a3e22bc@linux.intel.com>
Date:   Wed, 15 Nov 2023 18:18:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] Documentation/gpu: VM_BIND locking document
Content-Language: en-US
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
References: <20231115124937.6740-1-thomas.hellstrom@linux.intel.com>
 <ZVTfmbDz1HGqt4Ef@pollux>
 <62cdf31f6dbbb3a114755affc89d22fde875c3ff.camel@linux.intel.com>
 <05cf6199-3884-4e46-90ac-0b8df7420af7@redhat.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
In-Reply-To: <05cf6199-3884-4e46-90ac-0b8df7420af7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/15/23 18:02, Danilo Krummrich wrote:
> On 11/15/23 17:04, Thomas Hellström wrote:
>> Hi, Danilo,
>>
>> On Wed, 2023-11-15 at 16:11 +0100, Danilo Krummrich wrote:
>>> On Wed, Nov 15, 2023 at 01:49:37PM +0100, Thomas Hellström wrote:
>>>> Add the first version of the VM_BIND locking document which is
>>>> intended to be part of the xe driver upstreaming agreement.
>>>>
>>>> The document describes and discuss the locking used during exec-
>>>> functions, evicton and for userptr gpu-vmas. Intention is to be
>>>> using the
>>>> same nomenclature as the drm-vm-bind-async.rst.
>>>>
>>
>> Thanks for reviewing. I'll update the document accordingly except for
>> the s/an rwsem/a rwsem/g, I think it's "an rwsem" similarly to "an r".
>
> I read it as "read-write-sem". Would you read it as "ar-double-u-sem"
> then I guess?
>
Yes. :)

/Thomas


>>
>> /Thomas
>>
>
