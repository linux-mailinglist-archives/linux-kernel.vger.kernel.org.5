Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D867A83C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbjITNqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjITNqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:46:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FD8A1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695217526;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=ujgTQ3qDufxtYM9d31tejNUpUpn73FVEUPZ3OHRj4VM=;
        b=NfRXg3/Eo0y0TtSswgDucso8FU3AyZcFCxQ6j6lefHauWVUtXitpBS/Ctbn9f9cHCEnpP/
        LA9Mi5Pvl/iXKdY5RFrK+NHSLWMuNnrTcK+10o8k32RH91XJ2kbQnfdn5k+IV2C2bR/Pwy
        uMJUm5x/lLfBDwAvhfpMT+r3kSEWpAM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-gkLD6GTqPb-VgyoADgSo4A-1; Wed, 20 Sep 2023 09:45:23 -0400
X-MC-Unique: gkLD6GTqPb-VgyoADgSo4A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D3533C23FE9;
        Wed, 20 Sep 2023 13:45:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0021492C37;
        Wed, 20 Sep 2023 13:45:19 +0000 (UTC)
Date:   Wed, 20 Sep 2023 14:45:17 +0100
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        linux-coco@lists.linux.dev, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virt: tdx-guest: Add Quote generation support using
 TSM_REPORTS
Message-ID: <ZQr3bTtq6N+myZ4u@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20230914031349.23516-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230920131633.ig6ldmwavpu7uhss@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920131633.ig6ldmwavpu7uhss@box.shutemov.name>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 04:16:33PM +0300, Kirill A . Shutemov wrote:
> On Thu, Sep 14, 2023 at 03:13:49AM +0000, Kuppuswamy Sathyanarayanan wrote:
> > In TDX guest, the attestation process is used to verify the TDX guest
> > trustworthiness to other entities before provisioning secrets to the
> > guest. The First step in the attestation process is TDREPORT
> 
> s/First/first/ ?
> 
> > generation, which involves getting the guest measurement data in the
> > format of TDREPORT, which is further used to validate the authenticity
> > of the TDX guest. TDREPORT by design is integrity-protected and can
> > only be verified on the local machine.
> > 
> > To support remote verification of the TDREPORT (in a SGX-based
> > attestation), the TDREPORT needs to be sent to the SGX Quoting Enclave
> 
> Parentheses can be dropped.
> 
> > (QE) to convert it to a remotely verifiable Quote. SGX QE by design can
> > only run outside of the TDX guest (i.e. in a host process or in a
> > normal VM) and guest can use communication channels like vsock or
> > TCP/IP to send the TDREPORT to the QE. But for security concerns, the
> > TDX guest may not support these communication channels. To handle such
> > cases, TDX defines a GetQuote hypercall which can be used by the guest
> > to request the host VMM to communicate with the SGX QE. More details
> > about GetQuote hypercall can be found in TDX Guest-Host Communication
> > Interface (GHCI) for Intel TDX 1.0, section titled
> > "TDG.VP.VMCALL<GetQuote>".
> > 
> > Trusted Security Module (TSM) [1] exposes a common ABI for Confidential
> > Computing Guest platforms to get the measurement data via ConfigFS.
> > Extend the TSM framework and add support to allow an attestation agent
> > to get the TDX Quote data (included usage example below).
> > 
> >   report=/sys/kernel/config/tsm/report/report0
> >   mkdir $report
> >   dd if=/dev/urandom bs=64 count=1 > $report/inblob
> >   hexdump -C $report/outblob
> >   rmdir $report
> > 
> > GetQuote TDVMCALL requires TD guest pass a 4K aligned shared buffer
> > with TDREPORT data as input, which is further used by the VMM to copy
> > the TD Quote result after successful Quote generation. To create the
> > shared buffer, allocate a large enough memory and mark it shared using
> > set_memory_decrypted() in tdx_guest_init(). This buffer will be re-used
> > for GetQuote requests in the TDX TSM handler.
> > 
> > Although this method reserves a fixed chunk of memory for GetQuote
> > requests, such one time allocation can help avoid memory fragmentation
> > related allocation failures later in the uptime of the guest.
> > 
> > Since the Quote generation process is not time-critical or frequently
> > used, the current version uses a polling model for Quote requests and
> > it also does not support parallel GetQuote requests.
> > 
> > Link: https://lore.kernel.org/lkml/169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com/ [1]
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> The patch looks good to me. See one question below.

> > +static u8 *tdx_report_new(const struct tsm_desc *desc, void *data, size_t *outblob_len)
> > +{
> > +	struct tdx_quote_buf *quote_buf = quote_data;
> > +	int ret;
> > +	u8 *buf;
> > +	u64 err;
> > +
> > +	if (mutex_lock_interruptible(&quote_lock))
> > +		return ERR_PTR(-EINTR);
> > +
> > +	/*
> > +	 * If the previous request is timedout or interrupted, and the
> > +	 * Quote buf status is still in GET_QUOTE_IN_FLIGHT (owned by
> > +	 * VMM), don't permit any new request.
> > +	 */
> > +	if (quote_buf->status == GET_QUOTE_IN_FLIGHT) {
> > +		ret = -EBUSY;
> > +		goto done;
> > +	}
> > +
> > +	if (desc->inblob_len != TDX_REPORTDATA_LEN) {
> > +		ret = -EINVAL;
> > +		goto done;
> > +	}
> > +
> > +	/* TDX attestation only supports default format request */
> > +	if (desc->outblob_format != TSM_FORMAT_DEFAULT) {
> > +		ret = -EINVAL;
> > +		goto done;
> > +	}
> > +
> > +	u8 *reportdata __free(kfree) = kmalloc(TDX_REPORTDATA_LEN, GFP_KERNEL);
> 
> __free() is new to me. Good to know.
> 
> But are we okay now with declaring variables in the middle of the
> function? Any reason we can't do at the top?

I expect that to be unsafe and result in uninitialized data from the
stack being passed to kfree, if a "goto done" in the lines prior to
this declaration is triggered.

The 'reportdata' variable will be in scope at the "done:" label,
thus triggering the __free callback, but the 'kmalloc' initializer
will not have executed.

Variables should always be declared prior to any 'goto' statement
within the same block of scope, if relying on __attribute__((cleanup))
callbacks.

> 
> > +	if (!reportdata) {
> > +		ret = -ENOMEM;
> > +		goto done;
> > +	}
> > +
> > +	u8 *tdreport __free(kfree) = kzalloc(TDX_REPORT_LEN, GFP_KERNEL);
> > +	if (!tdreport) {
> > +		ret = -ENOMEM;
> > +		goto done;
> > +	}
> > +
> > +	memcpy(reportdata, desc->inblob, desc->inblob_len);
> > +
> > +	/* Generate TDREPORT0 using "TDG.MR.REPORT" TDCALL */
> > +	ret = tdx_mcall_get_report0(reportdata, tdreport);
> > +	if (ret) {
> > +		pr_err("GetReport call failed\n");
> > +		goto done;
> > +	}
> > +
> > +	memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
> > +
> > +	/* Update Quote buffer header */
> > +	quote_buf->version = GET_QUOTE_CMD_VER;
> > +	quote_buf->in_len = TDX_REPORT_LEN;
> > +
> > +	memcpy(quote_buf->data, tdreport, TDX_REPORT_LEN);
> > +
> > +	err = tdx_hcall_get_quote(quote_data, GET_QUOTE_BUF_SIZE);
> > +	if (err) {
> > +		pr_err("GetQuote hypercall failed, status:%llx\n", err);
> > +		ret = -EIO;
> > +		goto done;
> > +	}
> > +
> > +	ret = wait_for_quote_completion(quote_buf, getquote_timeout);
> > +	if (ret) {
> > +		pr_err("GetQuote request timedout\n");
> > +		goto done;
> > +	}
> > +
> > +	buf = kvmemdup(quote_buf->data, quote_buf->out_len, GFP_KERNEL);
> > +	if (!buf) {
> > +		ret = -ENOMEM;
> > +		goto done;
> > +	}
> > +
> > +	*outblob_len = quote_buf->out_len;
> > +
> > +done:
> > +	mutex_unlock(&quote_lock);
> > +	return ret ? ERR_PTR(ret) : buf;
> > +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

