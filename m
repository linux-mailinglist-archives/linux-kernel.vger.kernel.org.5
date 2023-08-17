Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D6877EE33
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 02:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347294AbjHQAXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 20:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347286AbjHQAXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 20:23:10 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B061BE2;
        Wed, 16 Aug 2023 17:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ns5iqF+88oYh3Uw7VK9v2BKp1aJm6RwQTXElNsrmfdk=; b=nVDBr+sI2kuQpgkQZz8sZNGzv6
        QADet1qvuWJYsiAhy8LzE1oZVWzR53B/JhzsjAnCFGFBuRqyRcKwa7UdoWwnUNGsjR8U/yA4hvu6V
        4YzweWNjwbW4Wo4qBox5XRe3SJzk1sJBHWbJ8aFcapUK1Ow9lw6h/lQAR0mYFZ8G+XzWOjKOQvyuZ
        QXOuP12bfAFX4YFA9lRcK9U/giUJkuVsqNnxoY4B56uMKSZiUAZGrO8wzCXiNyJDcwFxy1wjedDO6
        KKgSNAVCDvfMpxrfzoP24uL0ejIfFJ+OIY4M1J3h95Dn+GTspy+htiDS/78zOTuac4TdOnn4Ukg+H
        4aHak6GA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
        by mx.treblig.org with esmtp (Exim 4.94.2)
        (envelope-from <linux@treblig.org>)
        id 1qWQmw-007LI0-3n; Thu, 17 Aug 2023 00:22:57 +0000
From:   linux@treblig.org
To:     smfrench@gmail.com, dave.kleikamp@oracle.com, tom@talpey.com,
        pc@manguebit.com
Cc:     linkinjeon@kernel.org, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        krisman@collabora.com, "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v5 3/4] fs/smb/client: Use common code in client
Date:   Thu, 17 Aug 2023 01:22:31 +0100
Message-ID: <20230817002232.80079-4-linux@treblig.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817002232.80079-1-linux@treblig.org>
References: <20230817002232.80079-1-linux@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Now we've got the common code, use it for the client as well.
Note there's a change here where we're using the server version of
UniStrcat now which had different types (__le16 vs wchar_t) but
it's not interpreting the value other than checking for 0, however
we do need casts to keep sparse happy.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 fs/smb/client/Kconfig        |   1 +
 fs/smb/client/cifs_unicode.c |   1 -
 fs/smb/client/cifs_unicode.h | 280 +----------------------------------
 fs/smb/client/cifs_uniupr.h  | 123 ---------------
 fs/smb/client/smb2pdu.c      |   4 +-
 5 files changed, 4 insertions(+), 405 deletions(-)
 delete mode 100644 fs/smb/client/cifs_uniupr.h

diff --git a/fs/smb/client/Kconfig b/fs/smb/client/Kconfig
index 4c0d53bf931a..2927bd174a88 100644
--- a/fs/smb/client/Kconfig
+++ b/fs/smb/client/Kconfig
@@ -3,6 +3,7 @@ config CIFS
 	tristate "SMB3 and CIFS support (advanced network filesystem)"
 	depends on INET
 	select NLS
+	select NLS_UCS2_UTILS
 	select CRYPTO
 	select CRYPTO_MD5
 	select CRYPTO_SHA256
diff --git a/fs/smb/client/cifs_unicode.c b/fs/smb/client/cifs_unicode.c
index e7582dd79179..79d99a913944 100644
--- a/fs/smb/client/cifs_unicode.c
+++ b/fs/smb/client/cifs_unicode.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 #include "cifs_fs_sb.h"
 #include "cifs_unicode.h"
-#include "cifs_uniupr.h"
 #include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifs_debug.h"
diff --git a/fs/smb/client/cifs_unicode.h b/fs/smb/client/cifs_unicode.h
index 33b651def482..e137a0dfbbe9 100644
--- a/fs/smb/client/cifs_unicode.h
+++ b/fs/smb/client/cifs_unicode.h
@@ -21,19 +21,7 @@
 #include <asm/byteorder.h>
 #include <linux/types.h>
 #include <linux/nls.h>
-
-/*
- * Windows maps these to the user defined 16 bit Unicode range since they are
- * reserved symbols (along with \ and /), otherwise illegal to store
- * in filenames in NTFS
- */
-#define UNI_ASTERISK    (__u16) ('*' + 0xF000)
-#define UNI_QUESTION    (__u16) ('?' + 0xF000)
-#define UNI_COLON       (__u16) (':' + 0xF000)
-#define UNI_GRTRTHAN    (__u16) ('>' + 0xF000)
-#define UNI_LESSTHAN    (__u16) ('<' + 0xF000)
-#define UNI_PIPE        (__u16) ('|' + 0xF000)
-#define UNI_SLASH       (__u16) ('\\' + 0xF000)
+#include "../../nls/nls_ucs2_utils.h"
 
 /*
  * Macs use an older "SFM" mapping of the symbols above. Fortunately it does
@@ -66,22 +54,6 @@
 #define SFM_MAP_UNI_RSVD	1
 #define SFU_MAP_UNI_RSVD	2
 
-/* Just define what we want from uniupr.h.  We don't want to define the tables
- * in each source file.
- */
-#ifndef	UNICASERANGE_DEFINED
-struct UniCaseRange {
-	wchar_t start;
-	wchar_t end;
-	signed char *table;
-};
-#endif				/* UNICASERANGE_DEFINED */
-
-#ifndef UNIUPR_NOUPPER
-extern signed char CifsUniUpperTable[512];
-extern const struct UniCaseRange CifsUniUpperRange[];
-#endif				/* UNIUPR_NOUPPER */
-
 #ifdef __KERNEL__
 int cifs_from_utf16(char *to, const __le16 *from, int tolen, int fromlen,
 		    const struct nls_table *cp, int map_type);
@@ -101,254 +73,4 @@ extern __le16 *cifs_strndup_to_utf16(const char *src, const int maxlen,
 
 wchar_t cifs_toupper(wchar_t in);
 
-/*
- * UniStrcat:  Concatenate the second string to the first
- *
- * Returns:
- *     Address of the first string
- */
-static inline __le16 *
-UniStrcat(__le16 *ucs1, const __le16 *ucs2)
-{
-	__le16 *anchor = ucs1;	/* save a pointer to start of ucs1 */
-
-	while (*ucs1++) ;	/* To end of first string */
-	ucs1--;			/* Return to the null */
-	while ((*ucs1++ = *ucs2++)) ;	/* copy string 2 over */
-	return anchor;
-}
-
-/*
- * UniStrchr:  Find a character in a string
- *
- * Returns:
- *     Address of first occurrence of character in string
- *     or NULL if the character is not in the string
- */
-static inline wchar_t *
-UniStrchr(const wchar_t *ucs, wchar_t uc)
-{
-	while ((*ucs != uc) && *ucs)
-		ucs++;
-
-	if (*ucs == uc)
-		return (wchar_t *) ucs;
-	return NULL;
-}
-
-/*
- * UniStrcmp:  Compare two strings
- *
- * Returns:
- *     < 0:  First string is less than second
- *     = 0:  Strings are equal
- *     > 0:  First string is greater than second
- */
-static inline int
-UniStrcmp(const wchar_t *ucs1, const wchar_t *ucs2)
-{
-	while ((*ucs1 == *ucs2) && *ucs1) {
-		ucs1++;
-		ucs2++;
-	}
-	return (int) *ucs1 - (int) *ucs2;
-}
-
-/*
- * UniStrcpy:  Copy a string
- */
-static inline wchar_t *
-UniStrcpy(wchar_t *ucs1, const wchar_t *ucs2)
-{
-	wchar_t *anchor = ucs1;	/* save the start of result string */
-
-	while ((*ucs1++ = *ucs2++)) ;
-	return anchor;
-}
-
-/*
- * UniStrlen:  Return the length of a string (in 16 bit Unicode chars not bytes)
- */
-static inline size_t
-UniStrlen(const wchar_t *ucs1)
-{
-	int i = 0;
-
-	while (*ucs1++)
-		i++;
-	return i;
-}
-
-/*
- * UniStrnlen:  Return the length (in 16 bit Unicode chars not bytes) of a
- *		string (length limited)
- */
-static inline size_t
-UniStrnlen(const wchar_t *ucs1, int maxlen)
-{
-	int i = 0;
-
-	while (*ucs1++) {
-		i++;
-		if (i >= maxlen)
-			break;
-	}
-	return i;
-}
-
-/*
- * UniStrncat:  Concatenate length limited string
- */
-static inline wchar_t *
-UniStrncat(wchar_t *ucs1, const wchar_t *ucs2, size_t n)
-{
-	wchar_t *anchor = ucs1;	/* save pointer to string 1 */
-
-	while (*ucs1++) ;
-	ucs1--;			/* point to null terminator of s1 */
-	while (n-- && (*ucs1 = *ucs2)) {	/* copy s2 after s1 */
-		ucs1++;
-		ucs2++;
-	}
-	*ucs1 = 0;		/* Null terminate the result */
-	return (anchor);
-}
-
-/*
- * UniStrncmp:  Compare length limited string
- */
-static inline int
-UniStrncmp(const wchar_t *ucs1, const wchar_t *ucs2, size_t n)
-{
-	if (!n)
-		return 0;	/* Null strings are equal */
-	while ((*ucs1 == *ucs2) && *ucs1 && --n) {
-		ucs1++;
-		ucs2++;
-	}
-	return (int) *ucs1 - (int) *ucs2;
-}
-
-/*
- * UniStrncmp_le:  Compare length limited string - native to little-endian
- */
-static inline int
-UniStrncmp_le(const wchar_t *ucs1, const wchar_t *ucs2, size_t n)
-{
-	if (!n)
-		return 0;	/* Null strings are equal */
-	while ((*ucs1 == __le16_to_cpu(*ucs2)) && *ucs1 && --n) {
-		ucs1++;
-		ucs2++;
-	}
-	return (int) *ucs1 - (int) __le16_to_cpu(*ucs2);
-}
-
-/*
- * UniStrncpy:  Copy length limited string with pad
- */
-static inline wchar_t *
-UniStrncpy(wchar_t *ucs1, const wchar_t *ucs2, size_t n)
-{
-	wchar_t *anchor = ucs1;
-
-	while (n-- && *ucs2)	/* Copy the strings */
-		*ucs1++ = *ucs2++;
-
-	n++;
-	while (n--)		/* Pad with nulls */
-		*ucs1++ = 0;
-	return anchor;
-}
-
-/*
- * UniStrncpy_le:  Copy length limited string with pad to little-endian
- */
-static inline wchar_t *
-UniStrncpy_le(wchar_t *ucs1, const wchar_t *ucs2, size_t n)
-{
-	wchar_t *anchor = ucs1;
-
-	while (n-- && *ucs2)	/* Copy the strings */
-		*ucs1++ = __le16_to_cpu(*ucs2++);
-
-	n++;
-	while (n--)		/* Pad with nulls */
-		*ucs1++ = 0;
-	return anchor;
-}
-
-/*
- * UniStrstr:  Find a string in a string
- *
- * Returns:
- *     Address of first match found
- *     NULL if no matching string is found
- */
-static inline wchar_t *
-UniStrstr(const wchar_t *ucs1, const wchar_t *ucs2)
-{
-	const wchar_t *anchor1 = ucs1;
-	const wchar_t *anchor2 = ucs2;
-
-	while (*ucs1) {
-		if (*ucs1 == *ucs2) {
-			/* Partial match found */
-			ucs1++;
-			ucs2++;
-		} else {
-			if (!*ucs2)	/* Match found */
-				return (wchar_t *) anchor1;
-			ucs1 = ++anchor1;	/* No match */
-			ucs2 = anchor2;
-		}
-	}
-
-	if (!*ucs2)		/* Both end together */
-		return (wchar_t *) anchor1;	/* Match found */
-	return NULL;		/* No match */
-}
-
-#ifndef UNIUPR_NOUPPER
-/*
- * UniToupper:  Convert a unicode character to upper case
- */
-static inline wchar_t
-UniToupper(register wchar_t uc)
-{
-	register const struct UniCaseRange *rp;
-
-	if (uc < sizeof(CifsUniUpperTable)) {
-		/* Latin characters */
-		return uc + CifsUniUpperTable[uc];	/* Use base tables */
-	} else {
-		rp = CifsUniUpperRange;	/* Use range tables */
-		while (rp->start) {
-			if (uc < rp->start)	/* Before start of range */
-				return uc;	/* Uppercase = input */
-			if (uc <= rp->end)	/* In range */
-				return uc + rp->table[uc - rp->start];
-			rp++;	/* Try next range */
-		}
-	}
-	return uc;		/* Past last range */
-}
-
-/*
- * UniStrupr:  Upper case a unicode string
- */
-static inline __le16 *
-UniStrupr(register __le16 *upin)
-{
-	register __le16 *up;
-
-	up = upin;
-	while (*up) {		/* For all characters */
-		*up = cpu_to_le16(UniToupper(le16_to_cpu(*up)));
-		up++;
-	}
-	return upin;		/* Return input pointer */
-}
-#endif				/* UNIUPR_NOUPPER */
-
 #endif /* _CIFS_UNICODE_H */
diff --git a/fs/smb/client/cifs_uniupr.h b/fs/smb/client/cifs_uniupr.h
deleted file mode 100644
index b1d51d0da4fe..000000000000
--- a/fs/smb/client/cifs_uniupr.h
+++ /dev/null
@@ -1,123 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *   Copyright (c) International Business Machines  Corp., 2000,2002
- *
- * uniupr.h - Unicode compressed case ranges
-*/
-
-#ifndef UNIUPR_NOUPPER
-/*
- * Latin upper case
- */
-signed char CifsUniUpperTable[512] = {
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 000-00f */
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 010-01f */
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 020-02f */
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 030-03f */
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 040-04f */
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 050-05f */
-	0, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32,	/* 060-06f */
-	-32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, 0, 0, 0, 0, 0,	/* 070-07f */
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 080-08f */
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 090-09f */
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0a0-0af */
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0b0-0bf */
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0c0-0cf */
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0d0-0df */
-	-32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32,	/* 0e0-0ef */
-	-32, -32, -32, -32, -32, -32, -32, 0, -32, -32, -32, -32, -32, -32, -32, 121,	/* 0f0-0ff */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 100-10f */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 110-11f */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 120-12f */
-	0, 0, 0, -1, 0, -1, 0, -1, 0, 0, -1, 0, -1, 0, -1, 0,	/* 130-13f */
-	-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, 0, -1, 0, -1, 0, -1,	/* 140-14f */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 150-15f */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 160-16f */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, 0, -1, 0, -1, 0, -1, 0,	/* 170-17f */
-	0, 0, 0, -1, 0, -1, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0,	/* 180-18f */
-	0, 0, -1, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0,	/* 190-19f */
-	0, -1, 0, -1, 0, -1, 0, 0, -1, 0, 0, 0, 0, -1, 0, 0,	/* 1a0-1af */
-	-1, 0, 0, 0, -1, 0, -1, 0, 0, -1, 0, 0, 0, -1, 0, 0,	/* 1b0-1bf */
-	0, 0, 0, 0, 0, -1, -2, 0, -1, -2, 0, -1, -2, 0, -1, 0,	/* 1c0-1cf */
-	-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, -79, 0, -1, /* 1d0-1df */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e0-1ef */
-	0, 0, -1, -2, 0, -1, 0, 0, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1f0-1ff */
-};
-
-/* Upper case range - Greek */
-static signed char UniCaseRangeU03a0[47] = {
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -38, -37, -37, -37,	/* 3a0-3af */
-	0, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32,	/* 3b0-3bf */
-	-32, -32, -31, -32, -32, -32, -32, -32, -32, -32, -32, -32, -64,
-	-63, -63,
-};
-
-/* Upper case range - Cyrillic */
-static signed char UniCaseRangeU0430[48] = {
-	-32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32,	/* 430-43f */
-	-32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32,	/* 440-44f */
-	0, -80, -80, -80, -80, -80, -80, -80, -80, -80, -80, -80, -80, 0, -80, -80,	/* 450-45f */
-};
-
-/* Upper case range - Extended cyrillic */
-static signed char UniCaseRangeU0490[61] = {
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 490-49f */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 4a0-4af */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 4b0-4bf */
-	0, 0, -1, 0, -1, 0, 0, 0, -1, 0, 0, 0, -1,
-};
-
-/* Upper case range - Extended latin and greek */
-static signed char UniCaseRangeU1e00[509] = {
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e00-1e0f */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e10-1e1f */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e20-1e2f */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e30-1e3f */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e40-1e4f */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e50-1e5f */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e60-1e6f */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e70-1e7f */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e80-1e8f */
-	0, -1, 0, -1, 0, -1, 0, 0, 0, 0, 0, -59, 0, -1, 0, -1,	/* 1e90-1e9f */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1ea0-1eaf */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1eb0-1ebf */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1ec0-1ecf */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1ed0-1edf */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1ee0-1eef */
-	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0,	/* 1ef0-1eff */
-	8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1f00-1f0f */
-	8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1f10-1f1f */
-	8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1f20-1f2f */
-	8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1f30-1f3f */
-	8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1f40-1f4f */
-	0, 8, 0, 8, 0, 8, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1f50-1f5f */
-	8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1f60-1f6f */
-	74, 74, 86, 86, 86, 86, 100, 100, 0, 0, 112, 112, 126, 126, 0, 0,	/* 1f70-1f7f */
-	8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1f80-1f8f */
-	8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1f90-1f9f */
-	8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1fa0-1faf */
-	8, 8, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1fb0-1fbf */
-	0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1fc0-1fcf */
-	8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1fd0-1fdf */
-	8, 8, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1fe0-1fef */
-	0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-};
-
-/* Upper case range - Wide latin */
-static signed char UniCaseRangeUff40[27] = {
-	0, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32,	/* ff40-ff4f */
-	-32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32,
-};
-
-/*
- * Upper Case Range
- */
-const struct UniCaseRange CifsUniUpperRange[] = {
-	{0x03a0, 0x03ce, UniCaseRangeU03a0},
-	{0x0430, 0x045f, UniCaseRangeU0430},
-	{0x0490, 0x04cc, UniCaseRangeU0490},
-	{0x1e00, 0x1ffc, UniCaseRangeU1e00},
-	{0xff40, 0xff5a, UniCaseRangeUff40},
-	{0}
-};
-#endif
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index a457f07f820d..bbc45745bbfc 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2570,8 +2570,8 @@ alloc_path_with_tree_prefix(__le16 **out_path, int *out_size, int *out_len,
 
 	/* Do not append the separator if the path is empty */
 	if (path[0] != cpu_to_le16(0x0000)) {
-		UniStrcat(*out_path, sep);
-		UniStrcat(*out_path, path);
+		UniStrcat((wchar_t *)*out_path, (wchar_t *)sep);
+		UniStrcat((wchar_t *)*out_path, (wchar_t *)path);
 	}
 
 	unload_nls(cp);
-- 
2.41.0

