Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6FD783ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjHVH3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjHVH3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:29:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B6D137
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:29:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 93A771F381;
        Tue, 22 Aug 2023 07:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692689346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OH2sBOywqgJt743wIV+XGoKYbrfDK6sJlgU/TVWK92Q=;
        b=cqt+KMuAZA40KNliNgXpeAnz+lKf01zBvfD4L2oZt61ChrfSx59xWwAIF7cypvG8Hxai3g
        AqdpZPEIp7HWpJ2ibwzRNLDINdqmrnlOYe0K8022nfLIHYpA7Ry+YB1/MQyeP01UvuqSQc
        FPn+TC73rMuuK7inOJLrUvEvt5CorDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692689346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OH2sBOywqgJt743wIV+XGoKYbrfDK6sJlgU/TVWK92Q=;
        b=oYB0S5IzU12rHXxb7Dh3l4DSf6oEmJH9ASirjL6AC2gId9Dd2XdQqLZrJc5ad2U52C++jQ
        RQaiGZAbb2bW2zBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E87F113919;
        Tue, 22 Aug 2023 07:29:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uiY8NcFj5GRUVAAAMHmgww
        (envelope-from <rhopkins@suse.de>); Tue, 22 Aug 2023 07:29:05 +0000
Message-ID: <9e8938589b295b7ae8c4c281be886d065edf60a5.camel@suse.de>
Subject: Re: [PATCH v2 2/5] tsm: Introduce a shared ABI for attestation
 reports
From:   Roy Hopkins <rhopkins@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 22 Aug 2023 08:29:05 +0100
In-Reply-To: <169199900110.1782217.12112722316618515086.stgit@dwillia2-xfh.jf.intel.com>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
         <169199900110.1782217.12112722316618515086.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA4LTE0IGF0IDAwOjQzIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6Cj4g
T25lIG9mIHRoZSBjb21tb24gb3BlcmF0aW9ucyBvZiBhIFRTTSAoVHJ1c3RlZCBTZWN1cml0eSBN
b2R1bGUpIGlzIHRvCj4gcHJvdmlkZSBhIHdheSBmb3IgYSBUVk0gKGNvbmZpZGVudGlhbCBjb21w
dXRpbmcgZ3Vlc3QgZXhlY3V0aW9uCj4gZW52aXJvbm1lbnQpIHRvIHRha2UgYSBtZWFzdXJlbWVu
dCBvZiBpdHMgbGF1bmNoIHN0YXRlLCBzaWduIGl0IGFuZAo+IHN1Ym1pdCBpdCB0byBhIHZlcmlm
eWluZyBwYXJ0eS4gVXBvbiBzdWNjZXNzZnVsIGF0dGVzdGF0aW9uIHRoYXQKPiB2ZXJpZmllcyB0
aGUgaW50ZWdyaXR5IG9mIHRoZSBUVk0gYWRkaXRpb25hbCBzZWNyZXRzIG1heSBiZSBkZXBsb3ll
ZC4KPiBUaGUgY29uY2VwdCBpcyBjb21tb24gYWNyb3NzIFRTTXMsIGJ1dCB0aGUgaW1wbGVtZW50
YXRpb25zIGFyZQo+IHVuZm9ydHVuYXRlbHkgdmVuZG9yIHNwZWNpZmljLiBXaGlsZSB0aGUgaW5k
dXN0cnkgZ3JhcHBsZXMgd2l0aCBhIGNvbW1vbgo+IGRlZmluaXRpb24gb2YgdGhpcyBhdHRlc3Rh
dGlvbiBmb3JtYXQgWzFdLCBMaW51eCBuZWVkIG5vdCBtYWtlIHRoaXMKPiBwcm9ibGVtIHdvcnNl
IGJ5IGRlZmluaW5nIGEgbmV3IEFCSSBwZXIgVFNNIHRoYXQgd2FudHMgdG8gcGVyZm9ybSBhCj4g
c2ltaWxhciBvcGVyYXRpb24uIFRoZSBjdXJyZW50IG1vbWVudHVtIGhhcyBiZWVuIHRvIGludmVu
dCBuZXcgaW9jdGwtQUJJCj4gcGVyIFRTTSBwZXIgZnVuY3Rpb24gd2hpY2ggYXQgYmVzdCBpcyBh
biBhYmRpY2F0aW9uIG9mIHRoZSBrZXJuZWwncwo+IHJlc3BvbnNpYmlsaXR5IHRvIG1ha2UgY29t
bW9uIGluZnJhc3RydWN0dXJlIGNvbmNlcHRzIHNoYXJlIGNvbW1vbiBBQkkuCj4gCj4gVGhlIHBy
b3Bvc2FsLCB0YXJnZXRlZCB0byBjb25jZXB0dWFsbHkgd29yayB3aXRoIFREWCwgU0VWLCBDT1ZF
IGlmIG5vdAo+IG1vcmUsIGlzIHRvIGRlZmluZSBhIHN5c2ZzIGludGVyZmFjZSB0byByZXRyaWV2
ZSB0aGUgVFNNLXNwZWNpZmljIGJsb2IuCj4gCj4gwqDCoMKgIGVjaG8gJGhleF9lbmNvZGVkX3Vz
ZXJkYXRhX3BsdXNfbm9uY2UgPiAvc3lzL2NsYXNzL3RzbS90c20wL2luaGV4Cj4gwqDCoMKgIGhl
eGR1bXAgL3N5cy9jbGFzcy90c20vdHNtMC9vdXRibG9iCj4gCj4gVGhpcyBhcHByb2FjaCBsYXRl
ciBhbGxvd3MgZm9yIHRoZSBzdGFuZGFyZGl6YXRpb24gb2YgdGhlIGF0dGVzdGF0aW9uCj4gYmxv
YiBmb3JtYXQgd2l0aG91dCBuZWVkaW5nIHRvIGNoYW5nZSB0aGUgTGludXggQUJJLiBVbnRpbCB0
aGVuLCB0aGUKPiBmb3JtYXQgb2YgJ291dGJsb2InIGlzIGRldGVybWluZWQgYnkgdGhlIHBhcmVu
dCBkZXZpY2UgZm9yICd0c20wJy4KPiAKPiBUaGUgZXhwZWN0YXRpb24gaXMgdGhhdCB0aGlzIGlz
IGEgYm9vdCB0aW1lIGV4Y2hhbmdlIHRoYXQgbmVlZCBub3QgYmUKPiByZWdlbmVyYXRlZCwgbWFr
aW5nIGl0IGFtZW5hYmxlIHRvIGEgc3lzZnMgaW50ZXJmYWNlLiBJbiBjYXNlIHVzZXJzcGFjZQo+
IGRvZXMgdHJ5IHRvIGdlbmVyYXRlIG11bHRpcGxlIGF0dGVzdGF0aW9uIHJlcG9ydHMgaXQgaW5j
bHVkZXMgY29uZmxpY3QKPiBkZXRlY3Rpb24gc28gdXNlcnNwYWNlIGNhbiBiZSBzdXJlIG5vIG90
aGVyIHRocmVhZCBjaGFuZ2VkIHRoZQo+IHBhcmFtZXRlcnMgZnJvbSBpdHMgbGFzdCBjb25maWd1
cmF0aW9uIHN0ZXAgdG8gdGhlIGJsb2IgcmV0cmlldmFsLgo+IAo+IFRTTSBzcGVjaWZpYyBvcHRp
b25zIGFyZSBlbmNvZGVkIGFzICdleHRyYScgYXR0cmlidXRlcyBvbiB0aGUgVFNNIGRldmljZQo+
IHdpdGggdGhlIGV4cGVjdGF0aW9uIHRoYXQgdmVuZG9ycyByZXVzZSB0aGUgc2FtZSBvcHRpb25z
IGZvciBzaW1pbGFyCj4gY29uY2VwdHMuIFRoZSBjdXJyZW50IG9wdGlvbnMgYXJlIGRlZmluZWQg
YnkgU0VWLVNOUCdzIG5lZWQgZm9yIGEKPiAncHJpdmlsZWdlIGxldmVsJyBjb25jZXB0IChWTVBM
KSwgYW5kIHRoZSBvcHRpb24gdG8gcmV0cmlldmUgYQo+IGNlcnRpZmljYXRlIGNoYWluIGluIGFk
ZGl0aW9uIHRvIHRoZSBhdHRlc3RhdGlvbiByZXBvcnQgKCJleHRlbmRlZCIKPiBmb3JtYXQpLgo+
IAo+IExpbms6Cj4gaHR0cDovL2xvcmUua2VybmVsLm9yZy9yLzY0OTYxYzNiYWY4Y2VfMTQyYWY4
Mjk0MzZAZHdpbGxpYTIteGZoLmpmLmludGVsLmNvbS5ub3RtdWNoCj4gwqBbMV0KPiBDYzogS3Vw
cHVzd2FteSBTYXRoeWFuYXJheWFuYW4gPHNhdGh5YW5hcmF5YW5hbi5rdXBwdXN3YW15QGxpbnV4
LmludGVsLmNvbT4KPiBDYzogRGlvbm5hIEFtYWxpZSBHbGF6ZSA8ZGlvbm5hZ2xhemVAZ29vZ2xl
LmNvbT4KPiBDYzogSmFtZXMgQm90dG9tbGV5IDxKYW1lcy5Cb3R0b21sZXlASGFuc2VuUGFydG5l
cnNoaXAuY29tPgo+IENjOiBQZXRlciBHb25kYSA8cGdvbmRhQGdvb2dsZS5jb20+Cj4gQ2M6IEdy
ZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+Cj4gQ2M6IFNhbXVl
bCBPcnRpeiA8c2FtZW9Acml2b3NpbmMuY29tPgo+IFNpZ25lZC1vZmYtYnk6IERhbiBXaWxsaWFt
cyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPgo+IC0tLQo+IMKgRG9jdW1lbnRhdGlvbi9BQkkv
dGVzdGluZy9zeXNmcy1jbGFzcy10c20gfMKgwqAgNDcgKysrKysKPiDCoE1BSU5UQUlORVJTwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgwqAgOCArCj4gwqBkcml2ZXJzL3ZpcnQvY29jby9LY29uZmlnwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoCA0IAo+IMKgZHJpdmVycy92aXJ0L2NvY28vTWFrZWZp
bGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoCAxIAo+IMKgZHJpdmVycy92
aXJ0L2NvY28vdGR4LWd1ZXN0L0tjb25maWfCoMKgwqDCoMKgwqAgfMKgwqDCoCAxIAo+IMKgZHJp
dmVycy92aXJ0L2NvY28vdHNtLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDI5MAo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gwqBpbmNsdWRlL2xpbnV4
L3RzbS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAg
NDUgKysrKysKPiDCoDcgZmlsZXMgY2hhbmdlZCwgMzk2IGluc2VydGlvbnMoKykKPiDCoGNyZWF0
ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWNsYXNzLXRzbQo+
IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdmlydC9jb2NvL3RzbS5jCj4gwqBjcmVhdGUg
bW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC90c20uaAoKCj4gK3N0YXRpYyBzc2l6ZV90IG91dGJs
b2JfcmVhZChzdHJ1Y3QgZmlsZSAqZiwgc3RydWN0IGtvYmplY3QgKmtvYmosCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGJpbl9h
dHRyaWJ1dGUgKmJpbl9hdHRyLCBjaGFyICpidWYsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbG9mZl90IG9mZnNldCwgc2l6ZV90IGNvdW50
KQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgZ3VhcmQocndzZW1fcmVhZCkoJnRzbV9yd3NlbSk7Cj4g
K8KgwqDCoMKgwqDCoMKgaWYgKCF0c21fcmVwb3J0LmRlc2MuaW5ibG9iX2xlbikKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7Cj4gKwo+ICvCoMKgwqDCoMKg
wqDCoGlmICghdHNtX3JlcG9ydC5vdXRibG9iIHx8Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgIHRz
bV9yZXBvcnQucmVhZF9nZW5lcmF0aW9uICE9IHRzbV9yZXBvcnQud3JpdGVfZ2VuZXJhdGlvbikg
ewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1Y3QgdHNtX29wcyAq
b3BzID0gcHJvdmlkZXIub3BzOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzaXpl
X3Qgb3V0YmxvYl9sZW47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHU4ICpvdXRi
bG9iOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKga3ZmcmVlKHRzbV9yZXBv
cnQub3V0YmxvYik7CgpJIHRoaW5rIHRzbV9yZXBvcnQub3V0YmxvYiBuZWVkcyB0byBiZSBzZXQg
dG8gTlVMTCBoZXJlIG90aGVyd2lzZSB0aGVyZSBpcwp0aGUgcG9zc2liaWxpdHkgb2YgYSBkb3Vi
bGUtZnJlZSBpZiBvcHMtPnJlcG9ydF9uZXcgcmV0dXJucyBhbiBlcnJvci4KClJveQoKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgb3V0YmxvYiA9IG9wcy0+cmVwb3J0X25ldyhwcm92
aWRlci5kZXYtPnBhcmVudCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnRzbV9yZXBvcnQu
ZGVzYywgJm91dGJsb2JfbGVuKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYg
KElTX0VSUihvdXRibG9iKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiBQVFJfRVJSKG91dGJsb2IpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB0c21fcmVwb3J0Lm91dGJsb2JfbGVuID0gb3V0YmxvYl9sZW47Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRzbV9yZXBvcnQub3V0YmxvYiA9IG91dGJsb2I7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRzbV9yZXBvcnQucmVhZF9nZW5lcmF0aW9u
ID0gdHNtX3JlcG9ydC53cml0ZV9nZW5lcmF0aW9uOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiArCj4g
K8KgwqDCoMKgwqDCoMKgcmV0dXJuIG1lbW9yeV9yZWFkX2Zyb21fYnVmZmVyKGJ1ZiwgY291bnQs
ICZvZmZzZXQsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRzbV9yZXBvcnQub3V0YmxvYiwKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdHNtX3JlcG9ydC5vdXRibG9iX2xlbik7Cj4gK30KCg==

