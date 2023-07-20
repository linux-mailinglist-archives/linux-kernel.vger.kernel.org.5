Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81E075B2CE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjGTPel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjGTPej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:34:39 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5C8189;
        Thu, 20 Jul 2023 08:34:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4R6GcB0LRgz9xGWX;
        Thu, 20 Jul 2023 23:21:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBHquXFU7lkGHDRBA--.21759S2;
        Thu, 20 Jul 2023 16:33:41 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, pbrobinson@gmail.com,
        zbyszek@in.waw.pl, wiktor@metacode.biz,
        devel@lists.sequoia-pgp.org, gnupg-devel@gnupg.org,
        ebiggers@kernel.org, Jason@zx2c4.com, mail@maciej.szmigiero.name,
        antony@vennard.ch, konstantin@linuxfoundation.org,
        James.Bottomley@HansenPartnership.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 0/9] KEYS: Introduce user asymmetric keys and signatures
Date:   Thu, 20 Jul 2023 17:32:36 +0200
Message-Id: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHquXFU7lkGHDRBA--.21759S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JFyDJF47ZFy5JF15KFy7Awb_yoW3Aw17pF
        s5K3yftryktryIk395Jw1Igw1rZr1rAFW3Kw1fuw1rAasIqr18ArZ2kF4fur9IyFW0gF1F
        qr4Yvw1jkw1UtaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
        87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBF1jj5C8mgACsE
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Define a new TLV-based format for keys and signatures, aiming to store and
use in the kernel the crypto material from other unsupported formats
(e.g. PGP).

TLV fields have been defined to fill the corresponding kernel structures
public_key, public_key_signature and key_preparsed_payload.

Keys:
                struct public_key {     struct key_preparsed_payload {
KEY_PUB       -->  void *key;
                   u32 keylen;         --> prep->payload.data[asym_crypto]
KEY_ALGO      -->  const char *pkey_algo;
KEY_KID0
KEY_KID1      ---------------------------> prep->payload.data[asym_key_ids]
KEY_KID2  
KEY_DESC      ---------------------------> prep->description


Signatures:
                struct public_key_signature {
SIG_S         -->  u8 *s;
                   u32 s_size;
SIG_KEY_ALGO  -->  const char *pkey_algo;
SIG_HASH_ALGO -->  const char *hash_algo;
                   u32 digest_size;
SIG_ENC       -->  const char *encoding;   
SIG_KID0
SIG_KID1      -->  struct asymmetric_key_id *auth_ids[3];
SIG_KID2  


For keys, since the format conversion has to be done in user space, user
space is assumed to be trusted, in this proposal. Without this assumption,
a malicious conversion tool could make a user load to the kernel a
different key than the one expected.

That should not be a particular problem for keys that are embedded in the
kernel image and loaded at boot, since the conversion happens in a trusted
environment such as the building infrastructure of the Linux distribution
vendor.

In the other cases, such as enrolling a key through the Machine Owner Key
(MOK) mechanism, the user is responsible to ensure that the crypto material
carried in the original format remains the same after the conversion.

For signatures, assuming the strength of the crypto algorithms, altering
the crypto material is simply a Denial-of-Service (DoS), as data can be
validated only with the right signature.


This patch set also offers the following contributions:

- A library for parsing TLV-formatted data, usable also by other kernel
  subsystems

- An API similar to the PKCS#7 one, to verify the authenticity of system
  data through user asymmetric keys and signatures

- IMA support for user asymmetric keys and signatures embedded in a
  module-style appended signature (through the new API)

- A mechanism to store a keyring blob in the kernel image and to extract
  and load the keys at system boot
  
- A new command for gnupg (in user space), to convert keys and signatures
  from PGP to the new kernel format


The primary use case for this patch set is to verify the authenticity of
RPM package headers with the PGP keys of the Linux distribution. Once their
authenticity is verified, file digests can be extracted from those RPM
headers and used as reference values for IMA Appraisal.


Compared to the previous patch set, the main difference is not relying on
User Mode Drivers (UMDs) for the conversion from the original format to the
kernel format, due to the concern that full isolation of the UMD process
cannot be achieved against a fully privileged system user (root).

The discussion is still ongoing here:

https://lore.kernel.org/linux-integrity/eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com/

This however does not prevent the goal mentioned above of verifying the
authenticity of RPM headers to be achieved. The fact that Linux
distribution vendors do the conversion in their infrastructure is a good
enough guarantee.


A very quick way to test the patch set is to execute:

$ gpg --conv-kernel /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-rawhide-primary | keyctl padd asymmetric "" @u

$ keyctl show @u
Keyring
 762357580 --alswrv      0 65534  keyring: _uid.0
 567216072 --als--v      0     0   \_ asymmetric: PGP: 18b8e74c


Patch 1 introduces a common library for parsing TLV-formatted data. It is
generic enough to support other use cases other than this one.

Patches 2-3 preliminarly export some definitions to user space so that
conversion tools can specify the right public key algorithms and signature
encodings (digest algorithms are already exported).

Patches 4-5 introduce the user asymmetric keys and signatures.

Patches 6 introduces a system API for verifying the authenticity of system
data through user asymmetric keys and signatures.

Patch 7-8 introduce a mechanism to store a keyring blob with user
asymmetric keys in the kernel image, and load them at system boot.

Patch 9 adds support for verifying user asymmetric key signatures with IMA.

Patches 1-2 [GNUPG] introduce the new gpg command --conv-kernel to convert
PGP keys and signatures to the new kernel format.

Changelog

v2:
- Make the TLV parser a generic library and use it for user asymmetric keys
  and signatures
- Modify types in TLV header and data to u64 (future-proof)
- Move struct uasym_sig_message definition to uasym_sig_parser.c
- Remove eBPF patches (nacked by Alexei)
- Add IMA patch to support modsigs with a user asymmetric key signature

v1:
- Remove useless check in validate_key() (suggested by Yonghong)
- Don't rely on User Mode Drivers for the conversion from the original
  format to the kernel format
- Use the more extensible TLV format, instead of a fixed structure

Roberto Sassu (9):
  lib: Add TLV parser
  crypto: Export public key algorithm information
  crypto: Export signature encoding information
  KEYS: asymmetric: Introduce the user asymmetric key parser
  KEYS: asymmetric: Introduce the user asymmetric key signature parser
  verification: Add verify_uasym_signature() and
    verify_uasym_sig_message()
  KEYS: asymmetric: Preload user asymmetric keys from a keyring blob
  KEYS: Introduce load_uasym_keyring()
  ima: Support non-PKCS#7 modsig types

 MAINTAINERS                                |   9 +
 certs/Kconfig                              |  11 +
 certs/Makefile                             |   7 +
 certs/system_certificates.S                |  18 +
 certs/system_keyring.c                     | 166 ++++++-
 crypto/Kconfig                             |   6 +
 crypto/Makefile                            |   2 +
 crypto/asymmetric_keys/Kconfig             |  14 +
 crypto/asymmetric_keys/Makefile            |   8 +
 crypto/asymmetric_keys/asymmetric_type.c   |   3 +-
 crypto/asymmetric_keys/uasym_key_parser.c  | 240 ++++++++++
 crypto/asymmetric_keys/uasym_key_preload.c | 102 +++++
 crypto/asymmetric_keys/uasym_parser.h      |  26 ++
 crypto/asymmetric_keys/uasym_sig_parser.c  | 497 +++++++++++++++++++++
 crypto/pub_key_info.c                      |  20 +
 crypto/sig_enc_info.c                      |  16 +
 include/crypto/pub_key_info.h              |  15 +
 include/crypto/sig_enc_info.h              |  15 +
 include/crypto/uasym_keys_sigs.h           |  81 ++++
 include/keys/asymmetric-type.h             |   1 +
 include/linux/tlv_parser.h                 |  28 ++
 include/linux/verification.h               |  46 ++
 include/uapi/linux/pub_key_info.h          |  22 +
 include/uapi/linux/sig_enc_info.h          |  18 +
 include/uapi/linux/tlv_parser.h            |  59 +++
 include/uapi/linux/uasym_parser.h          |  59 +++
 lib/Kconfig                                |   3 +
 lib/Makefile                               |   3 +
 lib/tlv_parser.c                           | 203 +++++++++
 lib/tlv_parser.h                           |  17 +
 security/integrity/ima/ima_modsig.c        |  79 +++-
 31 files changed, 1771 insertions(+), 23 deletions(-)
 create mode 100644 crypto/asymmetric_keys/uasym_key_parser.c
 create mode 100644 crypto/asymmetric_keys/uasym_key_preload.c
 create mode 100644 crypto/asymmetric_keys/uasym_parser.h
 create mode 100644 crypto/asymmetric_keys/uasym_sig_parser.c
 create mode 100644 crypto/pub_key_info.c
 create mode 100644 crypto/sig_enc_info.c
 create mode 100644 include/crypto/pub_key_info.h
 create mode 100644 include/crypto/sig_enc_info.h
 create mode 100644 include/crypto/uasym_keys_sigs.h
 create mode 100644 include/linux/tlv_parser.h
 create mode 100644 include/uapi/linux/pub_key_info.h
 create mode 100644 include/uapi/linux/sig_enc_info.h
 create mode 100644 include/uapi/linux/tlv_parser.h
 create mode 100644 include/uapi/linux/uasym_parser.h
 create mode 100644 lib/tlv_parser.c
 create mode 100644 lib/tlv_parser.h

-- 
2.34.1

