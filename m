Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C10A75B30F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjGTPhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjGTPhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:37:17 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D3B2716;
        Thu, 20 Jul 2023 08:36:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6Gj00GQdz9xqxM;
        Thu, 20 Jul 2023 23:25:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBHquXFU7lkGHDRBA--.21759S13;
        Thu, 20 Jul 2023 16:36:02 +0100 (CET)
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
Subject: [RFC][GNUPG][PATCH v3 2/2] Convert PGP signatures to the user asymmetric key signatures format
Date:   Thu, 20 Jul 2023 17:32:47 +0200
Message-Id: <20230720153247.3755856-12-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
References: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHquXFU7lkGHDRBA--.21759S13
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWUur13Wr4fKr4DJryDtrb_yoW3Gry8pa
        sakFySqrW5Zrn3Kr43Gw4FqF13JwnYg3WDKFW7G3WS9wnIqrZFqF1jvFyIgryrGFWIgF18
        Ar4DXFZ7Wr4DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
        Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBF1jj4y-4AABsh
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

Enhance the gpg command --conv-kernel to also support converting PGP
signatures to the user asymmetric key signatures format.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 g10/conv-packet.c | 200 ++++++++++++++++++++++++++++++++++++++++++++++
 g10/conv-packet.h |   7 ++
 g10/mainproc.c    |   1 +
 3 files changed, 208 insertions(+)

diff --git a/g10/conv-packet.c b/g10/conv-packet.c
index 8f2fc40b980..be7eb3c80f8 100644
--- a/g10/conv-packet.c
+++ b/g10/conv-packet.c
@@ -28,6 +28,8 @@
 #include <linux/uasym_parser.h>
 #include <asm/byteorder.h>
 #include <linux/pub_key_info.h>
+#include <linux/sig_enc_info.h>
+#include <linux/hash_info.h>
 
 #include "gpg.h"
 #include "../common/util.h"
@@ -38,6 +40,16 @@
 
 static estream_t listfp;
 
+static const enum hash_algo pgp_hash_algorithms[DIGEST_ALGO_SHA224 + 1] = {
+  [DIGEST_ALGO_MD5]                = HASH_ALGO_MD5,
+  [DIGEST_ALGO_SHA1]               = HASH_ALGO_SHA1,
+  [DIGEST_ALGO_RMD160]             = HASH_ALGO_RIPE_MD_160,
+  [DIGEST_ALGO_SHA256]             = HASH_ALGO_SHA256,
+  [DIGEST_ALGO_SHA384]             = HASH_ALGO_SHA384,
+  [DIGEST_ALGO_SHA512]             = HASH_ALGO_SHA512,
+  [DIGEST_ALGO_SHA224]             = HASH_ALGO_SHA224,
+};
+
 static void init_output(void)
 {
   if (!listfp)
@@ -282,3 +294,191 @@ out:
   xfree(buffer);
   return 0;
 }
+
+/* Taken from sig_check.c */
+static int get_sig_data(PKT_signature * sig, __u8 **buf, __u32 *buf_len)
+{
+  __u8 *buf_ptr;
+
+  *buf = xmalloc_clear(4 + 2 + sig->hashed->len + 6);
+  if (!*buf)
+    return -ENOMEM;
+
+  buf_ptr = *buf;
+
+  if (sig->version >= 4)
+    *buf_ptr++ = sig->version;
+
+  *buf_ptr++ = sig->sig_class;
+  if (sig->version < 4)
+    {
+      u32 a = sig->timestamp;
+      *buf_ptr++ = ((a >> 24) & 0xff);
+      *buf_ptr++ = ((a >> 16) & 0xff);
+      *buf_ptr++ = ((a >>  8) & 0xff);
+      *buf_ptr++ = (a & 0xff);
+    }
+  else
+    {
+      size_t n;
+      *buf_ptr++ = sig->pubkey_algo;
+      *buf_ptr++ = sig->digest_algo;
+      if (sig->hashed)
+        {
+          n = sig->hashed->len;
+          *buf_ptr++ = n >> 8;
+          *buf_ptr++ = n;
+          memcpy(buf_ptr, sig->hashed->data, n);
+          buf_ptr += n;
+          n += 6;
+	}
+      else
+        {
+	  /* Two octets for the (empty) length of the hashed
+           * section. */
+          *buf_ptr++ = 0;
+	  *buf_ptr++ = 0;
+	  n = 6;
+	}
+      /* Add some magic per Section 5.2.4 of RFC 4880.  */
+      *buf_ptr++ = sig->version;
+      *buf_ptr++ = 0xff;
+      *buf_ptr++ = n >> 24;
+      *buf_ptr++ = n >> 16;
+      *buf_ptr++ = n >>  8;
+      *buf_ptr++ = n;
+    }
+
+    *buf_len = buf_ptr - *buf;
+    return 0;
+}
+
+int write_kernel_signature(PKT_signature *sig)
+{
+  unsigned char *buffer = NULL;
+  size_t buffer_len = 0, buffer_len_padded = 0;
+  struct tlv_hdr hdr = { 0 };
+  struct tlv_entry e_key_algo = { 0 };
+  struct tlv_entry e_hash_algo = { 0 };
+  struct tlv_entry e_sig_encoding = { 0 };
+  struct tlv_entry e_sig_kid0 = { 0 };
+  struct tlv_entry e_sig_pub = { 0 };
+  struct tlv_entry e_sig_data = { 0 };
+  __u8 pkey_algo;
+  __u8 hash_algo;
+  __u8 sig_encoding = SIG_ENC_PKCS1;
+  __u8 *sig_data = NULL;
+  __u32 _keyid, sig_data_len;
+  __u64 total_len = 0;
+  gpg_error_t err;
+  int ret = 0;
+
+  init_output();
+
+  ret = pgp_to_kernel_algo(sig->pubkey_algo, NULL, &pkey_algo);
+  if (ret < 0)
+    return ret;
+
+  if (pkey_algo == PKEY_ALGO_ECDSA)
+    sig_encoding = SIG_ENC_X962;
+
+  hash_algo = pgp_hash_algorithms[sig->digest_algo];
+
+  /* sig key algo */
+  e_key_algo.field = __cpu_to_be64(SIG_KEY_ALGO);
+  e_key_algo.length = __cpu_to_be64(sizeof(pkey_algo));
+  total_len += sizeof(e_key_algo) + sizeof(pkey_algo);
+
+  /* sig hash algo */
+  e_hash_algo.field = __cpu_to_be64(SIG_HASH_ALGO);
+  e_hash_algo.length = __cpu_to_be64(sizeof(hash_algo));
+  total_len += sizeof(e_hash_algo) + sizeof(hash_algo);
+
+  /* sig encoding */
+  e_sig_encoding.field = __cpu_to_be64(SIG_ENC);
+  e_sig_encoding.length = __cpu_to_be64(sizeof(sig_encoding));
+  total_len += sizeof(e_sig_encoding) + sizeof(sig_encoding);
+
+  /* sig kid0 */
+  e_sig_kid0.field = __cpu_to_be64(SIG_KID0);
+  e_sig_kid0.length = __cpu_to_be64(2 * sizeof(*sig->keyid));
+  total_len += sizeof(e_sig_kid0) + 2 * sizeof(*sig->keyid);
+
+  /* sig data */
+  e_sig_data.field = __cpu_to_be64(SIG_DATA_END);
+  ret = get_sig_data(sig, &sig_data, &sig_data_len);
+  if (ret < 0)
+    goto out;
+
+  e_sig_data.length = __cpu_to_be64(sig_data_len);
+  total_len += sizeof(e_sig_data) + sig_data_len;
+
+  switch (sig->pubkey_algo) {
+  case PUBKEY_ALGO_ECDSA:
+    ret = mpis_to_asn1_sequence(sig->data, 2, &buffer, &buffer_len_padded);
+    break;
+  case PUBKEY_ALGO_RSA:
+    err = gcry_mpi_print(GCRYMPI_FMT_USG, NULL, 0, &buffer_len, sig->data[0]);
+    if (err) {
+      ret = -EINVAL;
+      break;
+    }
+
+    buffer_len_padded = ((buffer_len + 7) / 8) * 8;
+    buffer = xmalloc_clear(buffer_len_padded);
+    if (!buffer) {
+      ret = -ENOMEM;
+      break;
+    }
+
+    err = gcry_mpi_print(GCRYMPI_FMT_USG,
+                         buffer + buffer_len_padded - buffer_len, buffer_len,
+                         &buffer_len, sig->data[0]);
+    if (err)
+      ret = -EINVAL;
+    break;
+  default:
+    ret = -EOPNOTSUPP;
+    break;
+  }
+
+  if (ret < 0)
+    goto out;
+
+  /* key blob */
+  e_sig_pub.field = __cpu_to_be64(SIG_S);
+  e_sig_pub.length = __cpu_to_be64(buffer_len_padded);
+  total_len += sizeof(e_sig_pub) + buffer_len_padded;
+
+  hdr.data_type = __cpu_to_be64(TYPE_SIG);
+  hdr.num_fields = __cpu_to_be64(6);
+  hdr.total_len = __cpu_to_be64(total_len);
+
+  es_write(listfp, &hdr, sizeof(hdr), NULL);
+
+  es_write(listfp, &e_key_algo, sizeof(e_key_algo), NULL);
+  es_write(listfp, &pkey_algo, sizeof(pkey_algo), NULL);
+
+  es_write(listfp, &e_hash_algo, sizeof(e_hash_algo), NULL);
+  es_write(listfp, &hash_algo, sizeof(hash_algo), NULL);
+
+  es_write(listfp, &e_sig_encoding, sizeof(e_sig_encoding), NULL);
+  es_write(listfp, &sig_encoding, sizeof(sig_encoding), NULL);
+
+  es_write(listfp, &e_sig_kid0, sizeof(e_sig_kid0), NULL);
+  _keyid = __cpu_to_be32(sig->keyid[0]);
+  es_write(listfp, &_keyid, sizeof(_keyid), NULL);
+  _keyid = __cpu_to_be32(sig->keyid[1]);
+  es_write(listfp, &_keyid, sizeof(_keyid), NULL);
+
+  es_write(listfp, &e_sig_pub, sizeof(e_sig_pub), NULL);
+  es_write(listfp, buffer, buffer_len_padded, NULL);
+
+  es_write(listfp, &e_sig_data, sizeof(e_sig_data), NULL);
+  es_write(listfp, sig_data, sig_data_len, NULL);
+
+out:
+  xfree(sig_data);
+  xfree(buffer);
+  return 0;
+}
diff --git a/g10/conv-packet.h b/g10/conv-packet.h
index d35acb985fc..ef718de0a7a 100644
--- a/g10/conv-packet.h
+++ b/g10/conv-packet.h
@@ -26,6 +26,7 @@
 
 #ifdef UASYM_KEYS_SIGS
 int write_kernel_key(PKT_public_key *pk);
+int write_kernel_signature(PKT_signature *sig);
 #else
 static inline int write_kernel_key(PKT_public_key *pk)
 {
@@ -33,5 +34,11 @@ static inline int write_kernel_key(PKT_public_key *pk)
    return 0;
 }
 
+static inline int write_kernel_signature(PKT_signature *sig)
+{
+   (void)sig;
+   return 0;
+}
+
 #endif /* UASYM_KEYS_SIGS */
 #endif /*G10_CONV_PACKET_H*/
diff --git a/g10/mainproc.c b/g10/mainproc.c
index edef9907127..1cb08d82000 100644
--- a/g10/mainproc.c
+++ b/g10/mainproc.c
@@ -502,6 +502,7 @@ proc_conv (PACKET *pkt)
   switch (pkt->pkttype)
     {
     case PKT_PUBLIC_KEY: write_kernel_key(pkt->pkt.public_key); break;
+    case PKT_SIGNATURE: write_kernel_signature(pkt->pkt.signature); break;
     default: break;
     }
   free_packet(pkt, NULL);
-- 
2.34.1

