Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AF180E402
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjLLFi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLFiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:38:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE67BD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 21:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702359541; x=1733895541;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=URPPQzLd2OI8UNUzOy+LBsiW7V7L/EcaPm3oslOKIC4=;
  b=nTlffpboGZpWrNXcswqaAHv52ZqlXfZAP25GSAK4u+tlaa0XdZQuYr3A
   5HZ4J6Z7iSVUNLZF2Lo/Z63t1ifvlHWhjSLV5xKONfeA68Swj+V2DT2JV
   ssHyV6NbKstnzW3aKhZPmo3x5DKERm0Plv6MjcYRWibK4Bm7eQU1+b5eG
   jksmlvHlvnZoEnjiroMA0JZe8EhmUCqc3Ki+x2uyYcUTHy3NXsOojzb/2
   NOG6EAOCOjibM2x8yI7IdKLUTZPFZTmyHkC97aVYNK6yMtDJwjEbbhjh/
   BIsev/1eqIVJe9UDWD6Pw2wGIQ/52Y2oxjrWOyBNgAqW3NWekiDEkDAw9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="461231777"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="461231777"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 21:39:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="917149775"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="917149775"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga001.fm.intel.com with ESMTP; 11 Dec 2023 21:38:58 -0800
Message-ID: <11b4b1db-2fde-413c-a203-0734bc18f4f7@linux.intel.com>
Date:   Tue, 12 Dec 2023 13:34:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iommu/vt-d: Setup scalable mode context entry in
 probe path
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
 <20231205012203.244584-2-baolu.lu@linux.intel.com>
 <20231211173826.GE1489931@ziepe.ca>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231211173826.GE1489931@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 1:38 AM, Jason Gunthorpe wrote:
> On Tue, Dec 05, 2023 at 09:21:58AM +0800, Lu Baolu wrote:
>> +/*
>> + * Get the PASID directory size for scalable mode context entry.
>> + * Value of X in the PDTS field of a scalable mode context entry
>> + * indicates PASID directory with 2^(X + 7) entries.
>> + */
>> +static unsigned long context_get_sm_pds(struct pasid_table *table)
>> +{
>> +	unsigned long pds, max_pde;
>> +
>> +	max_pde = table->max_pasid >> PASID_PDE_SHIFT;
>> +	pds = find_first_bit(&max_pde, MAX_NR_PASID_BITS);
>> +	if (pds < 7)
>> +		return 0;
>> +
>> +	return pds - 7;
> This seems like a convoluted way to write
>    max(ilog2(table-max_pasid) - 7,0)
> 
> ?

Yes. :-)

Something like,

     max(ilog2(table->max_pasid >> PASID_PDE_SHIFT) - 7, 0)

Best regards,
baolu
