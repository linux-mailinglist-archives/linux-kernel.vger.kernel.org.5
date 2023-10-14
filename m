Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0677C9461
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 13:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjJNLlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 07:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjJNLlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 07:41:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973BFD6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 04:41:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5E22F1F747;
        Sat, 14 Oct 2023 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697283662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=swyR2lTh8IorHFfM8C13WnAzd7dyD+cQ+Ci3iwRaodk=;
        b=lHv2HGmEIbiSnD8IeqYFs0NE3ypXxAXBCxRqG0phGtB3ACvPzLAfsNLtibQ7BEwxfJuJnW
        pikLdhRzstO+2l4Ho2fFlNSxMcIwLuob7eshnUKWBUMctMmn6HvxtDSthMeUZds2pJcd29
        FLSk62r6JCohpiZvxxq0d9rlcbs7yyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697283662;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=swyR2lTh8IorHFfM8C13WnAzd7dyD+cQ+Ci3iwRaodk=;
        b=uoG65aEXLqAVdqCahP/zjAb1O7Xh0ZgVc3+mXTA5TT2qqMrqI8B9Gj2wZZfppJwmfDBQuQ
        wlv1jGZkzMJq0VBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C79C51377D;
        Sat, 14 Oct 2023 11:41:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gI7tLE1+KmWzNAAAMHmgww
        (envelope-from <hare@suse.de>); Sat, 14 Oct 2023 11:41:01 +0000
Content-Type: multipart/mixed; boundary="------------sd071ddh80l3B60XbrvgK1kn"
Message-ID: <c60d34b1-5e2f-4b32-8519-c4a4ff89060a@suse.de>
Date:   Sat, 14 Oct 2023 13:41:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-auth: use transformed key size to create resp
Content-Language: en-US
To:     Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org,
        Akash Appaiah <Akash.Appaiah@dell.com>
References: <20231013202827.2262708-1-shiftee@posteo.net>
 <20231013202827.2262708-2-shiftee@posteo.net>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231013202827.2262708-2-shiftee@posteo.net>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -9.99
X-Spamd-Result: default: False [-9.99 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         XM_UA_NO_VERSION(0.01)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
         HAS_ATTACHMENT(0.00)[];
         REPLY(-4.00)[];
         MIME_BASE64_TEXT_BOGUS(1.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MIME_BASE64_TEXT(0.10)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------sd071ddh80l3B60XbrvgK1kn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/13/23 22:28, Mark O'Donovan wrote:
> This does not change current behaviour as the driver currently
> verifies that the secret size is the same size as the length of
> the transformation hash.
> 
> Co-developed-by: Akash Appaiah <Akash.Appaiah@dell.com>
> Signed-off-by: Akash Appaiah <Akash.Appaiah@dell.com>
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> ---
>   drivers/nvme/host/auth.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index daf5d144a8ea..e7d478d17b06 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -418,6 +418,14 @@ static int nvme_auth_set_dhchap_failure2_data(struct nvme_ctrl *ctrl,
>   	return size;
>   }
>   
> +static int nvme_auth_dhchap_transformed_key_len(struct nvme_dhchap_key *key)
> +{
> +	if (key->hash)
> +		return nvme_auth_hmac_hash_len(key->hash);
> +
> +	return key->len;
> +}
> +
>   static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
>   		struct nvme_dhchap_queue_context *chap)
>   {
> @@ -442,7 +450,8 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
>   	}
>   
>   	ret = crypto_shash_setkey(chap->shash_tfm,
> -			chap->host_response, ctrl->host_key->len);
> +			chap->host_response,
> +			nvme_auth_dhchap_transformed_key_len(ctrl->host_key));
>   	if (ret) {
>   		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
>   			 chap->qid, ret);

Hmm. Yeah, hash size vs secret size always gets me.
However, wouldn't it be better to return the key size from
nvme_auth_transform_key and us that directly?
(cf the attached patch)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

--------------sd071ddh80l3B60XbrvgK1kn
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-nvme-auth-use-length-of-the-transformed-key.patch"
Content-Disposition: attachment;
 filename="0001-nvme-auth-use-length-of-the-transformed-key.patch"
Content-Transfer-Encoding: base64

RnJvbSAxNGFjMDZhNTg2YzQ0Y2ExODZiNTI3MDA5NWY1NTFmM2JkYjc3ZjE4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4K
RGF0ZTogU2F0LCAxNCBPY3QgMjAyMyAxMzozNzozMSArMDIwMApTdWJqZWN0OiBbUEFUQ0hd
IG52bWUtYXV0aDogdXNlIGxlbmd0aCBvZiB0aGUgdHJhbnNmb3JtZWQga2V5CgpUaGUga2V5
IGxlbmd0aCBmb3IgZ2VuZXJhdGluZyB0aGUgaG9zdCByZXNwb25zZSBpcyB0aGUgbGVuZ3Ro
Cm9mIHRoZSB0cmFuc2Zvcm1lZCBob3N0IHJlc3BvbnNlLCB3aGljaCBtYXkgYmUgZGlmZmVy
ZW50IGZyb20KdGhlIGxlbmd0aCBvZiBob3N0IGtleS4KClNpZ25lZC1vZmYtYnk6IEhhbm5l
cyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgotLS0KIGRyaXZlcnMvbnZtZS9jb21tb24vYXV0
aC5jIHwgOSArKysrKysrLS0KIGRyaXZlcnMvbnZtZS9ob3N0L2F1dGguYyAgIHwgNyArKysr
Ky0tCiBpbmNsdWRlL2xpbnV4L252bWUtYXV0aC5oICB8IDMgKystCiAzIGZpbGVzIGNoYW5n
ZWQsIDE0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL2NvbW1vbi9hdXRoLmMgYi9kcml2ZXJzL252bWUvY29tbW9uL2F1dGguYwpp
bmRleCBkOTBlNGYwYzA4YjcuLmRkNWYxYTIyMWY1MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9u
dm1lL2NvbW1vbi9hdXRoLmMKKysrIGIvZHJpdmVycy9udm1lL2NvbW1vbi9hdXRoLmMKQEAg
LTIyOSw3ICsyMjksOCBAQCB2b2lkIG52bWVfYXV0aF9mcmVlX2tleShzdHJ1Y3QgbnZtZV9k
aGNoYXBfa2V5ICprZXkpCiB9CiBFWFBPUlRfU1lNQk9MX0dQTChudm1lX2F1dGhfZnJlZV9r
ZXkpOwogCi11OCAqbnZtZV9hdXRoX3RyYW5zZm9ybV9rZXkoc3RydWN0IG52bWVfZGhjaGFw
X2tleSAqa2V5LCBjaGFyICpucW4pCit1OCAqbnZtZV9hdXRoX3RyYW5zZm9ybV9rZXkoc3Ry
dWN0IG52bWVfZGhjaGFwX2tleSAqa2V5LCBjaGFyICpucW4sCisJCQkgICAgc2l6ZV90ICp0
cmFuc2Zvcm1lZF9sZW4pCiB7CiAJY29uc3QgY2hhciAqaG1hY19uYW1lOwogCXN0cnVjdCBj
cnlwdG9fc2hhc2ggKmtleV90Zm07CkBAIC0yNDMsNiArMjQ0LDggQEAgdTggKm52bWVfYXV0
aF90cmFuc2Zvcm1fa2V5KHN0cnVjdCBudm1lX2RoY2hhcF9rZXkgKmtleSwgY2hhciAqbnFu
KQogCX0KIAlpZiAoa2V5LT5oYXNoID09IDApIHsKIAkJdHJhbnNmb3JtZWRfa2V5ID0ga21l
bWR1cChrZXktPmtleSwga2V5LT5sZW4sIEdGUF9LRVJORUwpOworCQlpZiAodHJhbnNmb3Jt
ZWRfa2V5KQorCQkJKnRyYW5zZm9ybWVkX2xlbiA9IGtleS0+bGVuOwogCQlyZXR1cm4gdHJh
bnNmb3JtZWRfa2V5ID8gdHJhbnNmb3JtZWRfa2V5IDogRVJSX1BUUigtRU5PTUVNKTsKIAl9
CiAJaG1hY19uYW1lID0gbnZtZV9hdXRoX2htYWNfbmFtZShrZXktPmhhc2gpOwpAQCAtMjYz
LDcgKzI2Niw4IEBAIHU4ICpudm1lX2F1dGhfdHJhbnNmb3JtX2tleShzdHJ1Y3QgbnZtZV9k
aGNoYXBfa2V5ICprZXksIGNoYXIgKm5xbikKIAkJZ290byBvdXRfZnJlZV9rZXk7CiAJfQog
Ci0JdHJhbnNmb3JtZWRfa2V5ID0ga3phbGxvYyhjcnlwdG9fc2hhc2hfZGlnZXN0c2l6ZShr
ZXlfdGZtKSwgR0ZQX0tFUk5FTCk7CisJKnRyYW5zZm9ybWVkX2xlbiA9IGNyeXB0b19zaGFz
aF9kaWdlc3RzaXplKGtleV90Zm0pOworCXRyYW5zZm9ybWVkX2tleSA9IGt6YWxsb2MoKnRy
YW5zZm9ybWVkX2xlbiwgR0ZQX0tFUk5FTCk7CiAJaWYgKCF0cmFuc2Zvcm1lZF9rZXkpIHsK
IAkJcmV0ID0gLUVOT01FTTsKIAkJZ290byBvdXRfZnJlZV9zaGFzaDsKQEAgLTI5NCw2ICsy
OTgsNyBAQCB1OCAqbnZtZV9hdXRoX3RyYW5zZm9ybV9rZXkoc3RydWN0IG52bWVfZGhjaGFw
X2tleSAqa2V5LCBjaGFyICpucW4pCiBvdXRfZnJlZV90cmFuc2Zvcm1lZF9rZXk6CiAJa2Zy
ZWVfc2Vuc2l0aXZlKHRyYW5zZm9ybWVkX2tleSk7CiBvdXRfZnJlZV9zaGFzaDoKKwkqdHJh
bnNmb3JtZWRfbGVuID0gMDsKIAlrZnJlZShzaGFzaCk7CiBvdXRfZnJlZV9rZXk6CiAJY3J5
cHRvX2ZyZWVfc2hhc2goa2V5X3RmbSk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9z
dC9hdXRoLmMgYi9kcml2ZXJzL252bWUvaG9zdC9hdXRoLmMKaW5kZXggZGFmNWQxNDRhOGVh
Li45MjliMzc1MDJmMTIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2F1dGguYwor
KysgYi9kcml2ZXJzL252bWUvaG9zdC9hdXRoLmMKQEAgLTQwLDYgKzQwLDcgQEAgc3RydWN0
IG52bWVfZGhjaGFwX3F1ZXVlX2NvbnRleHQgewogCXU4ICpjdHJsX2tleTsKIAl1OCAqaG9z
dF9rZXk7CiAJdTggKnNlc3Nfa2V5OworCWludCBob3N0X3Jlc3BvbnNlX2xlbjsKIAlpbnQg
Y3RybF9rZXlfbGVuOwogCWludCBob3N0X2tleV9sZW47CiAJaW50IHNlc3Nfa2V5X2xlbjsK
QEAgLTQzMCwxMCArNDMxLDEyIEBAIHN0YXRpYyBpbnQgbnZtZV9hdXRoX2RoY2hhcF9zZXR1
cF9ob3N0X3Jlc3BvbnNlKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsCiAKIAlpZiAoIWNoYXAt
Pmhvc3RfcmVzcG9uc2UpIHsKIAkJY2hhcC0+aG9zdF9yZXNwb25zZSA9IG52bWVfYXV0aF90
cmFuc2Zvcm1fa2V5KGN0cmwtPmhvc3Rfa2V5LAotCQkJCQkJY3RybC0+b3B0cy0+aG9zdC0+
bnFuKTsKKwkJCQkJCWN0cmwtPm9wdHMtPmhvc3QtPm5xbiwKKwkJCQkJCSZjaGFwLT5ob3N0
X3Jlc3BvbnNlX2xlbik7CiAJCWlmIChJU19FUlIoY2hhcC0+aG9zdF9yZXNwb25zZSkpIHsK
IAkJCXJldCA9IFBUUl9FUlIoY2hhcC0+aG9zdF9yZXNwb25zZSk7CiAJCQljaGFwLT5ob3N0
X3Jlc3BvbnNlID0gTlVMTDsKKwkJCWNoYXAtPmhvc3RfcmVzcG9uc2VfbGVuID0gMDsKIAkJ
CXJldHVybiByZXQ7CiAJCX0KIAl9IGVsc2UgewpAQCAtNDQyLDcgKzQ0NSw3IEBAIHN0YXRp
YyBpbnQgbnZtZV9hdXRoX2RoY2hhcF9zZXR1cF9ob3N0X3Jlc3BvbnNlKHN0cnVjdCBudm1l
X2N0cmwgKmN0cmwsCiAJfQogCiAJcmV0ID0gY3J5cHRvX3NoYXNoX3NldGtleShjaGFwLT5z
aGFzaF90Zm0sCi0JCQljaGFwLT5ob3N0X3Jlc3BvbnNlLCBjdHJsLT5ob3N0X2tleS0+bGVu
KTsKKwkJCWNoYXAtPmhvc3RfcmVzcG9uc2UsIGNoYXAtPmhvc3RfcmVzcG9uc2VfbGVuKTsK
IAlpZiAocmV0KSB7CiAJCWRldl93YXJuKGN0cmwtPmRldmljZSwgInFpZCAlZDogZmFpbGVk
IHRvIHNldCBrZXksIGVycm9yICVkXG4iLAogCQkJIGNoYXAtPnFpZCwgcmV0KTsKZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvbnZtZS1hdXRoLmggYi9pbmNsdWRlL2xpbnV4L252bWUt
YXV0aC5oCmluZGV4IGRjYjgwMzAwNjJkZC4uNzJmNTk2MzJiZjM4IDEwMDY0NAotLS0gYS9p
bmNsdWRlL2xpbnV4L252bWUtYXV0aC5oCisrKyBiL2luY2x1ZGUvbGludXgvbnZtZS1hdXRo
LmgKQEAgLTI3LDcgKzI3LDggQEAgdTggbnZtZV9hdXRoX2htYWNfaWQoY29uc3QgY2hhciAq
aG1hY19uYW1lKTsKIHN0cnVjdCBudm1lX2RoY2hhcF9rZXkgKm52bWVfYXV0aF9leHRyYWN0
X2tleSh1bnNpZ25lZCBjaGFyICpzZWNyZXQsCiAJCQkJCSAgICAgIHU4IGtleV9oYXNoKTsK
IHZvaWQgbnZtZV9hdXRoX2ZyZWVfa2V5KHN0cnVjdCBudm1lX2RoY2hhcF9rZXkgKmtleSk7
Ci11OCAqbnZtZV9hdXRoX3RyYW5zZm9ybV9rZXkoc3RydWN0IG52bWVfZGhjaGFwX2tleSAq
a2V5LCBjaGFyICpucW4pOwordTggKm52bWVfYXV0aF90cmFuc2Zvcm1fa2V5KHN0cnVjdCBu
dm1lX2RoY2hhcF9rZXkgKmtleSwgY2hhciAqbnFuLAorCQkJICAgIHNpemVfdCAqdHJhbnNm
b3JtZWRfbGVuKTsKIGludCBudm1lX2F1dGhfZ2VuZXJhdGVfa2V5KHU4ICpzZWNyZXQsIHN0
cnVjdCBudm1lX2RoY2hhcF9rZXkgKipyZXRfa2V5KTsKIGludCBudm1lX2F1dGhfYXVnbWVu
dGVkX2NoYWxsZW5nZSh1OCBobWFjX2lkLCB1OCAqc2tleSwgc2l6ZV90IHNrZXlfbGVuLAog
CQkJCSAgdTggKmNoYWxsZW5nZSwgdTggKmF1Zywgc2l6ZV90IGhsZW4pOwotLSAKMi4zNS4z
Cgo=

--------------sd071ddh80l3B60XbrvgK1kn--
