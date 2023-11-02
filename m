Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663647DF389
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376331AbjKBNTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKBNTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:19:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCBC134
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698931154; x=1730467154;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=74BJtLzAsCxWbJvgvhbKysL0xlsclDFAgogg3ikLZaU=;
  b=nTRG/y+5kOyEVrNjMZnqNTnZKFTHQnJ0ymHf7UKrIF2KrKCPLgIpuemf
   4h5LHOzcZHgktitdrG4rboAjqcazarwDzAMTEAXw8HRRFG+qo4GjKfHsH
   k2Ru5j50gHKXlY46d0MgVNNbASlFbKX0sM4ckrs9uznP8vVB1q5JzZrwg
   9FsEyzDwjNvcDsD3ua6MAEoPoBrmBCLe2J7tEd4Bys1AZmcl5Gd2zQ0Y5
   ArvJnc+H6q+AeicegbVcr9IgxLABXoszuiKjJHTk++2ohyuB5JKVK8Y08
   4X4svFWHPAaqPaDsIkEwe2yCzCJawYfDPqm5wA7LD0Po2ancE4FvXDwiQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="453011112"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="453011112"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 06:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="827133184"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="827133184"
Received: from binsumax-mobl.gar.corp.intel.com (HELO [10.249.254.171]) ([10.249.254.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 06:19:10 -0700
Message-ID: <754fd9054f5021edaa92232d457760bcd6ac083e.camel@linux.intel.com>
Subject: Re: [PATCH drm-misc-next v8 02/12] drm/gpuvm: don't always WARN in
 drm_gpuvm_check_overflow()
From:   Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 02 Nov 2023 14:19:08 +0100
In-Reply-To: <20231101233113.8059-3-dakr@redhat.com>
References: <20231101233113.8059-1-dakr@redhat.com>
         <20231101233113.8059-3-dakr@redhat.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTExLTAyIGF0IDAwOjMwICswMTAwLCBEYW5pbG8gS3J1bW1yaWNoIHdyb3Rl
Ogo+IERvbid0IGFsd2F5cyBXQVJOIGluIGRybV9ncHV2bV9jaGVja19vdmVyZmxvdygpIGFuZCBz
ZXBhcmF0ZSBpdCBpbnRvCj4gYQo+IGRybV9ncHV2bV9jaGVja19vdmVyZmxvdygpIGFuZCBhIGRl
ZGljYXRlZAo+IGRybV9ncHV2bV93YXJuX2NoZWNrX292ZXJmbG93KCkgdmFyaWFudC4KPiAKPiBU
aGlzIGF2b2lkcyBwcmludGluZyB3YXJuaW5ncyBkdWUgdG8gaW52YWxpZCB1c2Vyc3BhY2UgcmVx
dWVzdHMuCj4gCj4gU2lnbmVkLW9mZi1ieTogRGFuaWxvIEtydW1tcmljaCA8ZGFrckByZWRoYXQu
Y29tPgpSZXZpZXdlZC1ieTogVGhvbWFzIEhlbGxzdHLDtm0gPHRob21hcy5oZWxsc3Ryb21AbGlu
dXguaW50ZWwuY29tPgoKPiAtLS0KPiDCoGRyaXZlcnMvZ3B1L2RybS9kcm1fZ3B1dm0uYyB8IDIw
ICsrKysrKysrKysrKystLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KSwgNyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9n
cHV2bS5jCj4gYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2dwdXZtLmMKPiBpbmRleCBkNzM2N2EyMDJm
ZWUuLjQ0NTc2N2Y4ZmJjNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2dwdXZt
LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2dwdXZtLmMKPiBAQCAtNjE0LDEyICs2MTQs
MTggQEAgc3RhdGljIGludCBfX2RybV9ncHV2YV9pbnNlcnQoc3RydWN0IGRybV9ncHV2bQo+ICpn
cHV2bSwKPiDCoHN0YXRpYyB2b2lkIF9fZHJtX2dwdXZhX3JlbW92ZShzdHJ1Y3QgZHJtX2dwdXZh
ICp2YSk7Cj4gwqAKPiDCoHN0YXRpYyBib29sCj4gLWRybV9ncHV2bV9jaGVja19vdmVyZmxvdyhz
dHJ1Y3QgZHJtX2dwdXZtICpncHV2bSwgdTY0IGFkZHIsIHU2NAo+IHJhbmdlKQo+ICtkcm1fZ3B1
dm1fY2hlY2tfb3ZlcmZsb3codTY0IGFkZHIsIHU2NCByYW5nZSkKPiDCoHsKPiDCoMKgwqDCoMKg
wqDCoMKgdTY0IGVuZDsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoHJldHVybiBkcm1fV0FSTihncHV2
bS0+ZHJtLCBjaGVja19hZGRfb3ZlcmZsb3coYWRkciwgcmFuZ2UsCj4gJmVuZCksCj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAiR1BVVkEgYWRkcmVzcyBs
aW1pdGVkIHRvICV6dSBieXRlcy5cbiIsCj4gc2l6ZW9mKGVuZCkpOwo+ICvCoMKgwqDCoMKgwqDC
oHJldHVybiBjaGVja19hZGRfb3ZlcmZsb3coYWRkciwgcmFuZ2UsICZlbmQpOwo+ICt9Cj4gKwo+
ICtzdGF0aWMgYm9vbAo+ICtkcm1fZ3B1dm1fd2Fybl9jaGVja19vdmVyZmxvdyhzdHJ1Y3QgZHJt
X2dwdXZtICpncHV2bSwgdTY0IGFkZHIsIHU2NAo+IHJhbmdlKQo+ICt7Cj4gK8KgwqDCoMKgwqDC
oMKgcmV0dXJuIGRybV9XQVJOKGdwdXZtLT5kcm0sIGRybV9ncHV2bV9jaGVja19vdmVyZmxvdyhh
ZGRyLAo+IHJhbmdlKSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCJHUFVWQSBhZGRyZXNzIGxpbWl0ZWQgdG8gJXp1IGJ5dGVzLlxuIiwKPiBzaXplb2Yo
YWRkcikpOwo+IMKgfQo+IMKgCj4gwqBzdGF0aWMgYm9vbAo+IEBAIC02NDcsNyArNjUzLDcgQEAg
c3RhdGljIGJvb2wKPiDCoGRybV9ncHV2bV9yYW5nZV92YWxpZChzdHJ1Y3QgZHJtX2dwdXZtICpn
cHV2bSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTY0IGFk
ZHIsIHU2NCByYW5nZSkKPiDCoHsKPiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gIWRybV9ncHV2bV9j
aGVja19vdmVyZmxvdyhncHV2bSwgYWRkciwgcmFuZ2UpICYmCj4gK8KgwqDCoMKgwqDCoMKgcmV0
dXJuICFkcm1fZ3B1dm1fY2hlY2tfb3ZlcmZsb3coYWRkciwgcmFuZ2UpICYmCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBkcm1fZ3B1dm1faW5fbW1fcmFuZ2UoZ3B1dm0sIGFkZHIsIHJh
bmdlKSAmJgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIWRybV9ncHV2bV9pbl9rZXJu
ZWxfbm9kZShncHV2bSwgYWRkciwgcmFuZ2UpOwo+IMKgfQo+IEBAIC02ODIsNyArNjg4LDcgQEAg
ZHJtX2dwdXZtX2luaXQoc3RydWN0IGRybV9ncHV2bSAqZ3B1dm0sIGNvbnN0Cj4gY2hhciAqbmFt
ZSwKPiDCoMKgwqDCoMKgwqDCoMKgZ3B1dm0tPm9wcyA9IG9wczsKPiDCoMKgwqDCoMKgwqDCoMKg
Z3B1dm0tPmRybSA9IGRybTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoGRybV9ncHV2bV9jaGVja19v
dmVyZmxvdyhncHV2bSwgc3RhcnRfb2Zmc2V0LCByYW5nZSk7Cj4gK8KgwqDCoMKgwqDCoMKgZHJt
X2dwdXZtX3dhcm5fY2hlY2tfb3ZlcmZsb3coZ3B1dm0sIHN0YXJ0X29mZnNldCwgcmFuZ2UpOwo+
IMKgwqDCoMKgwqDCoMKgwqBncHV2bS0+bW1fc3RhcnQgPSBzdGFydF9vZmZzZXQ7Cj4gwqDCoMKg
wqDCoMKgwqDCoGdwdXZtLT5tbV9yYW5nZSA9IHJhbmdlOwo+IMKgCj4gQEAgLTY5MSw4ICs2OTcs
OCBAQCBkcm1fZ3B1dm1faW5pdChzdHJ1Y3QgZHJtX2dwdXZtICpncHV2bSwgY29uc3QKPiBjaGFy
ICpuYW1lLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ3B1dm0tPmtlcm5lbF9h
bGxvY19ub2RlLnZhLmFkZHIgPSByZXNlcnZlX29mZnNldDsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGdwdXZtLT5rZXJuZWxfYWxsb2Nfbm9kZS52YS5yYW5nZSA9IHJlc2VydmVf
cmFuZ2U7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGxpa2VseSgh
ZHJtX2dwdXZtX2NoZWNrX292ZXJmbG93KGdwdXZtLAo+IHJlc2VydmVfb2Zmc2V0LAo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzZXJ2ZV9yYW5nZSkp
KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAobGlrZWx5KCFkcm1fZ3B1dm1f
d2Fybl9jaGVja19vdmVyZmxvdyhncHV2bSwKPiByZXNlcnZlX29mZnNldCwKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IHJlc2VydmVf
cmFuZ2UpKSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBfX2RybV9ncHV2YV9pbnNlcnQoZ3B1dm0sICZncHV2bS0KPiA+a2VybmVsX2FsbG9jX25vZGUp
Owo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqB9Cgo=

