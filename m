Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512337AF7B9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 03:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbjI0BkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 21:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbjI0Bh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 21:37:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8438E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 17:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695775389; x=1727311389;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZG48JsDdvLaa/pIy5X+5hIbN2j0336Ug4RIAW09D50Y=;
  b=LeNIn8vGIv02kO8ND+nnyNRLseJ2Dsw2ryOhBeG04InODYGuetV2YSnB
   HwiBVWp5DCKlfWJlBnoNs6QqQdJqQ5djT5ZhgWNP3fOqOR2k5xaG7uzlA
   KzokIhArc8uD/+Rnf1MPq23LVupEfi5U/ZGj5nzMC7kxRQxkHWkfiq0hi
   fAt3KPhyPibzzrHt/l1Ypx7VxjgSu3xO5Iu0qVQDUMJSF4mBtlBl+d7F4
   JOco4+snG3GTIDU6ZlU1gSbOeIeb4Vt4bpbxVyYKnO95GXrA9g1rPA8b6
   TIcivqZQKKmSaCTQKhj5MwNNNwYOZA7xUqiC2n43+k6p1OsPKQfB8i7m5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="467986614"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="467986614"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 17:43:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="778333267"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="778333267"
Received: from cchiu4-mobl.gar.corp.intel.com (HELO [10.212.145.91]) ([10.212.145.91])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 17:43:08 -0700
Message-ID: <668e7778-e1f6-48a8-9631-0643c1ce9e4f@linux.intel.com>
Date:   Tue, 26 Sep 2023 17:43:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] configfs-tsm: Introduce a shared ABI for
 attestation reports
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com
References: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
 <169570182987.596431.14062417344858914481.stgit@dwillia2-xfh.jf.intel.com>
 <c3d347a7-58d6-4830-aad4-d354b83f0704@linux.intel.com>
 <651329fed4947_124e929464@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <651329fed4947_124e929464@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/2023 11:59 AM, Dan Williams wrote:
> Kuppuswamy Sathyanarayanan wrote:
>> Hi Dan,
>>
>> On 9/25/2023 9:17 PM, Dan Williams wrote:
>>> One of the common operations of a TSM (Trusted Security Module) is to
>>> provide a way for a TVM (confidential computing guest execution
>>> environment) to take a measurement of its launch state, sign it and
>>> submit it to a verifying party. Upon successful attestation that
>>> verifies the integrity of the TVM additional secrets may be deployed.
>>> The concept is common across TSMs, but the implementations are
>>> unfortunately vendor specific. While the industry grapples with a common
>>> definition of this attestation format [1], Linux need not make this
>>> problem worse by defining a new ABI per TSM that wants to perform a
>>> similar operation. The current momentum has been to invent new ioctl-ABI
>>> per TSM per function which at best is an abdication of the kernel's
>>> responsibility to make common infrastructure concepts share common ABI.
>>>
>>> The proposal, targeted to conceptually work with TDX, SEV-SNP, COVE if
>>> not more, is to define a configfs interface to retrieve the TSM-specific
>>> blob.
>>>
>>>     report=/sys/kernel/config/tsm/report/report0
>>>     mkdir $report
>>>     dd if=binary_userdata_plus_nonce > $report/inblob
>>>     hexdump $report/outblob
>>>
>>> This approach later allows for the standardization of the attestation
>>> blob format without needing to invent a new ABI. Once standardization
>>> happens the standard format can be emitted by $report/outblob and
>>> indicated by $report/provider, or a new attribute like
>>> "$report/tcg_coco_report" can emit the standard format alongside the
>>> vendor format.
>>>
>>> Review of previous iterations of this interface identified that there is
>>> a need to scale report generation for multiple container environments
>>> [2]. Configfs enables a model where each container can bind mount one or
>>> more report generation item instances. Still, within a container only a
>>> single thread can be manipulating a given configuration instance at a
>>> time. A 'generation' count is provided to detect conflicts between
>>> multiple threads racing to configure a report instance.
>>>
>>> The SEV-SNP concepts of "extended reports" and "privilege levels" are
>>> optionally enabled by selecting 'tsm_report_ext_type' at register_tsm()
>>> time. The expectation is that those concepts are generic enough that
>>> they may be adopted by other TSM implementations. In other words,
>>> configfs-tsm aims to address a superset of TSM specific functionality
>>> with a common ABI where attributes may appear, or not appear, based on the set
>>> of concepts the implementation supports.
>>>
>>> Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
>>> Link: http://lore.kernel.org/r/57f3a05e-8fcd-4656-beea-56bb8365ae64@linux.microsoft.com [2]
>>> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
>>> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
>>> Cc: Peter Gonda <pgonda@google.com>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Samuel Ortiz <sameo@rivosinc.com>
>>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Acked-by: Thomas Gleixner <tglx@linutronix.de>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> [..]
>>> +static ssize_t __read_report(struct tsm_report *report, void *buf, size_t count,
>>> +			     enum tsm_data_select select)
>>> +{
>>> +	loff_t offset = 0;
>>> +	u8 *out, len;
>>> +
>>> +	if (select == TSM_REPORT) {
>>> +		out = report->outblob;
>>> +		len = report->outblob_len;
>>> +	} else {
>>> +		out = report->certs;
>>> +		len = report->certs_len;
>>> +	}
>>> +
>>
>> Since we get out and len from arch_ops, I think we can check for null condition before
>> attempting the memory_read_from_buffer()
>>
>>> +	if (!buf)
>>> +		return len;
>>
>> buf cannot be NULL, right? Do you want this check? If you want to leave it,
>> in NULL condition it should return 0 bytes, right?
> 
> No, and this might deserve a comment for folks that are not familiar
> with how configfs works, but configfs calls an attribute's ->read()
> helper with @buf == NULL to say "please tell me how many bytes are
> available, and I will call you back again to fill in the buffer at that
> size".
> 

Got it. Thanks for clarifying it.

>>
>>> +	return memory_read_from_buffer(buf, count, &offset, out, len);
>>> +}
>>> +
>>> +static ssize_t read_cached_report(struct tsm_report *report, void *buf,
>>> +				  size_t count, enum tsm_data_select select)
>>> +{
>>> +	struct tsm_report_state *state = to_state(report);
>>> +
>>> +	guard(rwsem_read)(&tsm_rwsem);
>>> +	if (!report->desc.inblob_len)
>>> +		return -EINVAL;
>>> +
>>> +	/*
>>> +	 * A given TSM backend always fills in ->outblob regardless of
>>> +	 * whether the report includes certs or not.
>>> +	 */
>>> +	if (!report->outblob ||
>>> +	    state->read_generation != state->write_generation)
>>> +		return -EWOULDBLOCK;
>>> +
>>> +	return __read_report(report, buf, count, select);
>>> +}
>>> +
>>> +static ssize_t tsm_report_read(struct tsm_report *report, void *buf,
>>> +			       size_t count, enum tsm_data_select select)
>>> +{
>>> +	struct tsm_report_state *state = to_state(report);
>>> +	const struct tsm_ops *ops;
>>> +	ssize_t rc;
>>> +
>>> +	/* try to read from the existing report if present and valid... */
>>> +	rc = read_cached_report(report, buf, count, select);
>>> +	if (rc >= 0 || rc != -EWOULDBLOCK)
>>> +		return rc;
>>> +
>>> +	/* slow path, report may need to be regenerated... */
>>> +	guard(rwsem_write)(&tsm_rwsem);
>>> +	ops = provider.ops;
>>> +	if (!report->desc.inblob_len)
>>> +		return -EINVAL;
>>> +
>>> +	/* did another thread already generate this report? */
>>> +	if (report->outblob &&
>>> +	    state->read_generation == state->write_generation)
>>> +		goto out;
>>> +
>>> +	kvfree(report->outblob);
>>> +	kvfree(report->certs);
>>> +	report->outblob = NULL;
>>> +	report->certs = NULL;
>>
>> Since you are clearing outblob and certs, do you want to reset the outblob_len and certs_len?
> 
> Not strictly necessary, nothing in the code is checking _len for whether
> the report is ready or not.

ok.

> 
> [..]
>>> +/**
>>> + * struct tsm_desc - option descriptor for generating tsm report blobs
>>> + * @privlevel: optional privilege level to associate with @outblob
>>> + * @inblob_len: sizeof @inblob
>>> + * @inblob: arbitrary input data
>>> + */
>>> +struct tsm_desc {
>>> +	unsigned int privlevel;
>>> +	size_t inblob_len;
>>> +	u8 inblob[TSM_INBLOB_MAX];
>>> +};
>>> +
>>> +/**
>>> + * struct tsm_report - track state of report generation relative to options
>>> + * @desc: report generation options / cached report state
>>> + * @outblob: generated evidence to provider to the attestation agent
>>> + * @outblob_len: sizeof(outblob)
>>
>> I think following is incorrect. You might want to add info about certs_len
>> and certs.
> 
> Yeah, missed updating this with certs addition. The outblob_len
> definition is correct, or do you mean the kdoc is out of order with
> respect to the struct?

No, I am talking about the write_generation, read_generation and cfg options.
They are part of struct tsm_report_state, so why document it here?

> 
>>
>>> + * @write_generation: conflict detection, and report regeneration tracking
>>> + * @read_generation: cached report invalidation tracking
>>> + * @cfg: configfs interface
>>> + */
>>> +struct tsm_report {
>>> +	struct tsm_desc desc;
>>> +	size_t outblob_len;
>>> +	u8 *outblob;
>>> +	size_t certs_len;
>>> +	u8 *certs;
>>> +};
>>> +
>>> +/*
>>> + * arch specific ops, only one is expected to be registered at a time
>>> + * i.e. only one of SEV, TDX, COVE, etc.
>>> + */
>>
>> Since it is ARCH specific ops, I think adding some info about its members
>> will be helpful. Like what is report_new callback and its acceptable
>> return values.
> 
> Sure.
> 
> Will wait for positive test feedback about the sev-guest changes before
> spinning this series again.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
