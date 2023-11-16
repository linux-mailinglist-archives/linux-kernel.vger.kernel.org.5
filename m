Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399457EE72D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjKPTLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKPTLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:11:16 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CFE1A8;
        Thu, 16 Nov 2023 11:11:12 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50970c2115eso1787835e87.1;
        Thu, 16 Nov 2023 11:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700161870; x=1700766670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HvqoSmET7AGneC0DU+9vvXM7mU+Afpt1Gl2P+52o3jI=;
        b=bPTzU4/q8JqrgXJ+fQZSq/aWqpH7hf1mh4lavpeNeHyaLOUoihyjLoQI0aY2re5rBu
         eSWMw/KZUNvJO9GQGXHFbX+2AdPWmiUsLmsKbf7qrEAxZy+ysFyzrjnw83bZwgekQUZW
         dRTSAXsORz1SKPPXH5QBys6mewE7V+H+iEfDvHGlIohP30CrlIwLzxm4BjYSuNOiEZOj
         8awYKaThax7T5n7vUa1l1lPQ3VlTrtgiPIC3JkPegZz82D3mvg62VDfZiRN004yDvTFu
         bkDbWkgy/Nt06VKmtEH3ucPcr0KQoermMZhPOkv01xfgp7lXumunb20L6z/2/yhPGOvm
         MRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700161870; x=1700766670;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvqoSmET7AGneC0DU+9vvXM7mU+Afpt1Gl2P+52o3jI=;
        b=xB98dfGwm8D2ixC2nmswiROsSaxbKnHWaWAe3sagW363+lQlco02msD321z0ICJfu/
         7GyXU9BRnJCOe0zKLTwhaQdcRQtEq9aaYuqCr/apUvqLG2XRXXiPmtXx8N6+cfbLF1+y
         Cki1srSu5ceWP6Yi0GAbAM3IoTQNFq/NpLcXv5eUlNpN6lu8br5OF2mNu6mmW/zFOHQ1
         CKV12SADlBeOQGA2R6FmVziNnnUoYAxyqBkeSizl4W8CpU6iQlS+7cP39dIEeBXObFbd
         VJJ8fpU5/stMro6bnNtpQCQwqwQ5TnLn4vjKnt+K2D2WytT8utQ3HcEycP0Esp+2xdrk
         7gZg==
X-Gm-Message-State: AOJu0Yw7U4vW6NOoHHhBAIFKvMXcCbRNLK41h1fcs9IYkVdDEv7e8bpl
        sytRC5vd9BRkqTY7qG0G4O2AdzFPjcVlqerZdFvU08H4SEPphQ==
X-Google-Smtp-Source: AGHT+IFRVCxgaf/Z3tqusQJxhVAgc3v+PKDVWuF/KqBZYrhhWCHzv/pxlMIixAMYXwSLHgQOvnmQmNNwffletgg3BXU=
X-Received: by 2002:a19:6409:0:b0:509:4e4f:65ac with SMTP id
 y9-20020a196409000000b005094e4f65acmr10428397lfb.63.1700161870144; Thu, 16
 Nov 2023 11:11:10 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 16 Nov 2023 13:10:58 -0600
Message-ID: <CAH2r5mu8NBbW3ipMYd-UdfV+oDA1R7mwV-A8=PzU5qrd4kEiGg@mail.gmail.com>
Subject: [PATCH][SMB client] two multichannel patches
To:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000005558fa060a49c8f3"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000005558fa060a49c8f3
Content-Type: text/plain; charset="UTF-8"

Any thoughts on these two multichannel patches from Shyam (attached)?

The first fixes: "cifs: account for primary channel in the interface
list" which fixes a refcounting issue in channel deallocation.  The
second fixes a lock ordering problem in the recent patch: "cifs:
handle when server stops supporting multichannel"

The code to handle the case of server disabling multichannel
was picking iface_lock with chan_lock held. This goes against
the lock ordering rules, as iface_lock is a higher order lock
(even if it isn't so obvious).

This change fixes the lock ordering by doing the following in
that order for each secondary channel:
1. store iface and server pointers in local variable
2. remove references to iface and server in channels
3. unlock chan_lock
4. lock iface_lock
5. dec ref count for iface
6. unlock iface_lock
7. dec ref count for server
8. lock chan_lock again

Let me know if any test feedback or reviews

-- 
Thanks,

Steve

--0000000000005558fa060a49c8f3
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-fix-leak-of-iface-for-primary-channel.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-fix-leak-of-iface-for-primary-channel.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lp1kgb1d0>
X-Attachment-Id: f_lp1kgb1d0

RnJvbSAyOTk1NGQ1YjFlMGQ2N2E0Y2Q2MWMzMGMyMjAxMDMwYzk3ZTk0YjFlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaHlhbSBQcmFzYWQgTiA8c3ByYXNhZEBtaWNyb3NvZnQuY29t
PgpEYXRlOiBUdWUsIDE0IE5vdiAyMDIzIDA0OjU0OjEyICswMDAwClN1YmplY3Q6IFtQQVRDSCAx
LzJdIGNpZnM6IGZpeCBsZWFrIG9mIGlmYWNlIGZvciBwcmltYXJ5IGNoYW5uZWwKCk15IGxhc3Qg
Y2hhbmdlIGluIHRoaXMgYXJlYSBpbnRyb2R1Y2VkIGEgY2hhbmdlIHdoaWNoCmFjY291bnRlZCBm
b3IgcHJpbWFyeSBjaGFubmVsIGluIHRoZSBpbnRlcmZhY2UgcmVmIGNvdW50LgpIb3dldmVyLCBp
dCBkaWQgbm90IHJlZHVjZSB0aGlzIHJlZiBjb3VudCBvbiBkZWFsbG9jYXRpb24Kb2YgdGhlIHBy
aW1hcnkgY2hhbm5lbC4gaS5lLiBkdXJpbmcgdW1vdW50LgoKRml4aW5nIHRoaXMgbGVhayBoZXJl
LCBieSBkcm9wcGluZyB0aGlzIHJlZiBjb3VudCBmb3IKcHJpbWFyeSBjaGFubmVsIHdoaWxlIGZy
ZWVpbmcgdXAgdGhlIHNlc3Npb24uCgpGaXhlczogZmExZDA1MDhiZGQ0ICgiY2lmczogYWNjb3Vu
dCBmb3IgcHJpbWFyeSBjaGFubmVsIGluIHRoZSBpbnRlcmZhY2UgbGlzdCIpCkNjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnClJlcG9ydGVkLWJ5OiBQYXVsbyBBbGNhbnRhcmEgPHBjQG1hbmd1ZWJp
dC5jb20+ClNpZ25lZC1vZmYtYnk6IFNoeWFtIFByYXNhZCBOIDxzcHJhc2FkQG1pY3Jvc29mdC5j
b20+ClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZyZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4K
LS0tCiBmcy9zbWIvY2xpZW50L2Nvbm5lY3QuYyB8IDYgKysrKysrCiAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvc21iL2NsaWVudC9jb25uZWN0LmMgYi9m
cy9zbWIvY2xpZW50L2Nvbm5lY3QuYwppbmRleCA1N2MyYTdkZjM0NTcuLmY4OTZmNjBjOTI0YiAx
MDA2NDQKLS0tIGEvZnMvc21iL2NsaWVudC9jb25uZWN0LmMKKysrIGIvZnMvc21iL2NsaWVudC9j
b25uZWN0LmMKQEAgLTIwNjUsNiArMjA2NSwxMiBAQCB2b2lkIF9fY2lmc19wdXRfc21iX3Nlcyhz
dHJ1Y3QgY2lmc19zZXMgKnNlcykKIAkJc2VzLT5jaGFuc1tpXS5zZXJ2ZXIgPSBOVUxMOwogCX0K
IAorCS8qIHdlIG5vdyBhY2NvdW50IGZvciBwcmltYXJ5IGNoYW5uZWwgaW4gaWZhY2UtPnJlZmNv
dW50ICovCisJaWYgKHNlcy0+Y2hhbnNbMF0uaWZhY2UpIHsKKwkJa3JlZl9wdXQoJnNlcy0+Y2hh
bnNbMF0uaWZhY2UtPnJlZmNvdW50LCByZWxlYXNlX2lmYWNlKTsKKwkJc2VzLT5jaGFuc1swXS5z
ZXJ2ZXIgPSBOVUxMOworCX0KKwogCXNlc0luZm9GcmVlKHNlcyk7CiAJY2lmc19wdXRfdGNwX3Nl
c3Npb24oc2VydmVyLCAwKTsKIH0KLS0gCjIuMzkuMgoK
--0000000000005558fa060a49c8f3
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-cifs-fix-lock-ordering-while-disabling-multichannel.patch"
Content-Disposition: attachment; 
	filename="0002-cifs-fix-lock-ordering-while-disabling-multichannel.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lp1kgf651>
X-Attachment-Id: f_lp1kgf651

RnJvbSA1ZWVmMTJjNGUzMjMwZjIwMjVkYzQ2YWQ4YzRhM2JjMTk5NzhlNWQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaHlhbSBQcmFzYWQgTiA8c3ByYXNhZEBtaWNyb3NvZnQuY29t
PgpEYXRlOiBUdWUsIDE0IE5vdiAyMDIzIDA0OjU4OjIzICswMDAwClN1YmplY3Q6IFtQQVRDSCAy
LzJdIGNpZnM6IGZpeCBsb2NrIG9yZGVyaW5nIHdoaWxlIGRpc2FibGluZyBtdWx0aWNoYW5uZWwK
ClRoZSBjb2RlIHRvIGhhbmRsZSB0aGUgY2FzZSBvZiBzZXJ2ZXIgZGlzYWJsaW5nIG11bHRpY2hh
bm5lbAp3YXMgcGlja2luZyBpZmFjZV9sb2NrIHdpdGggY2hhbl9sb2NrIGhlbGQuIFRoaXMgZ29l
cyBhZ2FpbnN0CnRoZSBsb2NrIG9yZGVyaW5nIHJ1bGVzLCBhcyBpZmFjZV9sb2NrIGlzIGEgaGln
aGVyIG9yZGVyIGxvY2sKKGV2ZW4gaWYgaXQgaXNuJ3Qgc28gb2J2aW91cykuCgpUaGlzIGNoYW5n
ZSBmaXhlcyB0aGUgbG9jayBvcmRlcmluZyBieSBkb2luZyB0aGUgZm9sbG93aW5nIGluCnRoYXQg
b3JkZXIgZm9yIGVhY2ggc2Vjb25kYXJ5IGNoYW5uZWw6CjEuIHN0b3JlIGlmYWNlIGFuZCBzZXJ2
ZXIgcG9pbnRlcnMgaW4gbG9jYWwgdmFyaWFibGUKMi4gcmVtb3ZlIHJlZmVyZW5jZXMgdG8gaWZh
Y2UgYW5kIHNlcnZlciBpbiBjaGFubmVscwozLiB1bmxvY2sgY2hhbl9sb2NrCjQuIGxvY2sgaWZh
Y2VfbG9jawo1LiBkZWMgcmVmIGNvdW50IGZvciBpZmFjZQo2LiB1bmxvY2sgaWZhY2VfbG9jawo3
LiBkZWMgcmVmIGNvdW50IGZvciBzZXJ2ZXIKOC4gbG9jayBjaGFuX2xvY2sgYWdhaW4KClNpbmNl
IHRoaXMgZnVuY3Rpb24gY2FuIG9ubHkgYmUgY2FsbGVkIGluIHNtYjJfcmVjb25uZWN0LCBhbmQK
dGhhdCBjYW5ub3QgYmUgY2FsbGVkIGJ5IHR3byBwYXJhbGxlbCBwcm9jZXNzZXMsIHdlIHNob3Vs
ZCBub3QKaGF2ZSByYWNlcyBkdWUgdG8gZHJvcHBpbmcgY2hhbl9sb2NrIGJldHdlZW4gc3RlcHMg
MyBhbmQgOC4KCkZpeGVzOiBlZTFkMjE3OTRlNTUgKCJjaWZzOiBoYW5kbGUgd2hlbiBzZXJ2ZXIg
c3RvcHMgc3VwcG9ydGluZyBtdWx0aWNoYW5uZWwiKQpSZXBvcnRlZC1ieTogUGF1bG8gQWxjYW50
YXJhIDxwY0BtYW5ndWViaXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTaHlhbSBQcmFzYWQgTiA8c3By
YXNhZEBtaWNyb3NvZnQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNo
QG1pY3Jvc29mdC5jb20+Ci0tLQogZnMvc21iL2NsaWVudC9zZXNzLmMgfCAyMiArKysrKysrKysr
KysrLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50L3Nlc3MuYyBiL2ZzL3NtYi9jbGllbnQv
c2Vzcy5jCmluZGV4IDBiYjJhYzkyOTA2MS4uOGIyZDdjMWNhNDI4IDEwMDY0NAotLS0gYS9mcy9z
bWIvY2xpZW50L3Nlc3MuYworKysgYi9mcy9zbWIvY2xpZW50L3Nlc3MuYwpAQCAtMzIyLDI4ICsz
MjIsMzIgQEAgY2lmc19kaXNhYmxlX3NlY29uZGFyeV9jaGFubmVscyhzdHJ1Y3QgY2lmc19zZXMg
KnNlcykKIAkJaWZhY2UgPSBzZXMtPmNoYW5zW2ldLmlmYWNlOwogCQlzZXJ2ZXIgPSBzZXMtPmNo
YW5zW2ldLnNlcnZlcjsKIAorCQkvKgorCQkgKiByZW1vdmUgdGhlc2UgcmVmZXJlbmNlcyBmaXJz
dCwgc2luY2Ugd2UgbmVlZCB0byB1bmxvY2sKKwkJICogdGhlIGNoYW5fbG9jayBoZXJlLCBzaW5j
ZSBpZmFjZV9sb2NrIGlzIGEgaGlnaGVyIGxvY2sKKwkJICovCisJCXNlcy0+Y2hhbnNbaV0uaWZh
Y2UgPSBOVUxMOworCQlzZXMtPmNoYW5zW2ldLnNlcnZlciA9IE5VTEw7CisJCXNwaW5fdW5sb2Nr
KCZzZXMtPmNoYW5fbG9jayk7CisKIAkJaWYgKGlmYWNlKSB7CiAJCQlzcGluX2xvY2soJnNlcy0+
aWZhY2VfbG9jayk7CiAJCQlrcmVmX3B1dCgmaWZhY2UtPnJlZmNvdW50LCByZWxlYXNlX2lmYWNl
KTsKLQkJCXNlcy0+Y2hhbnNbaV0uaWZhY2UgPSBOVUxMOwogCQkJaWZhY2UtPm51bV9jaGFubmVs
cy0tOwogCQkJaWYgKGlmYWNlLT53ZWlnaHRfZnVsZmlsbGVkKQogCQkJCWlmYWNlLT53ZWlnaHRf
ZnVsZmlsbGVkLS07CiAJCQlzcGluX3VubG9jaygmc2VzLT5pZmFjZV9sb2NrKTsKIAkJfQogCi0J
CXNwaW5fdW5sb2NrKCZzZXMtPmNoYW5fbG9jayk7Ci0JCWlmIChzZXJ2ZXIgJiYgIXNlcnZlci0+
dGVybWluYXRlKSB7Ci0JCQlzZXJ2ZXItPnRlcm1pbmF0ZSA9IHRydWU7Ci0JCQljaWZzX3NpZ25h
bF9jaWZzZF9mb3JfcmVjb25uZWN0KHNlcnZlciwgZmFsc2UpOwotCQl9Ci0JCXNwaW5fbG9jaygm
c2VzLT5jaGFuX2xvY2spOwotCiAJCWlmIChzZXJ2ZXIpIHsKLQkJCXNlcy0+Y2hhbnNbaV0uc2Vy
dmVyID0gTlVMTDsKKwkJCWlmICghc2VydmVyLT50ZXJtaW5hdGUpIHsKKwkJCQlzZXJ2ZXItPnRl
cm1pbmF0ZSA9IHRydWU7CisJCQkJY2lmc19zaWduYWxfY2lmc2RfZm9yX3JlY29ubmVjdChzZXJ2
ZXIsIGZhbHNlKTsKKwkJCX0KIAkJCWNpZnNfcHV0X3RjcF9zZXNzaW9uKHNlcnZlciwgZmFsc2Up
OwogCQl9CiAKKwkJc3Bpbl9sb2NrKCZzZXMtPmNoYW5fbG9jayk7CiAJfQogCiBkb25lOgotLSAK
Mi4zOS4yCgo=
--0000000000005558fa060a49c8f3--
