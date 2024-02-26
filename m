Return-Path: <linux-kernel+bounces-81411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79523867597
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A401F26E38
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B2680037;
	Mon, 26 Feb 2024 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="KXQbP9/1"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C31060860;
	Mon, 26 Feb 2024 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951790; cv=none; b=fC2vU6E3cv/VyPdO/huiISP4PUl7KxZFrXOtszmZ4/8wSy2Jm3RucDdRnGW2V0QCkQym6VDI5KWRmStTctJnpq4pkAHxhFdqdeZ22maE8O5T0U4+0qNKePIjIymS4w7zMYfIK1K1f+U7BrkCOM6KYHae4QiUQzBde247xy7Yupw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951790; c=relaxed/simple;
	bh=ytKZ3NbHf5MhqswaN0jKGgkBfXXHhJSXuMoH1wb5nxk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SFtcRKCKpC+RwB142wJEtOP4kBPB4YrgLwk/HpQ9KGXwtyY6cXaNbL4fUqI7DR9df2xIaIMPXNDNPwM/AIjQSOIARyvRKB4LaMXhCgBsP5Q5AGDD/VpKEzW7QDO8lmGZHK3cIBbSEAI4LtwKsbLBvxUkb5bpR0QL+lFDfjV7KMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=KXQbP9/1; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id BA6EE200A71D;
	Mon, 26 Feb 2024 13:49:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be BA6EE200A71D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708951778;
	bh=Hwyx8dGRuIF5+W3hinASB76ZcsD02bl2T99vjRiBnz8=;
	h=From:To:Cc:Subject:Date:From;
	b=KXQbP9/1qvPBcQFElM9GAP3fbqf20LVGY2eJXY/wiJCTBokwYTK8OBJpF/0EzNReq
	 rS+C4OI0sbQtNR6hq5F6ZS2umIMp5rd1bEewIb5RPnmYUKEE5ngqmrJCahhhcapEb7
	 +aZ7MSpTb+FecS9d6p5ZGfzO5VzRNZ3fkEQj0IEo5jzWfk6A1A5/XJgkpKu/NoLm9o
	 h/r8YDzvP96kCVwnz2rAJkLxZ0z+swRWVSdqMPod5xLT6++7HqUggUoHgbluK25aa6
	 5MPvCnHPeM9s/FVG9yvU0CaPLBcTqcgW4XvNDRzoSCqgSiHL8dODhIOpppWsTqipe4
	 nL2fN9G8QxCEA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net] uapi: in6: replace temporary label with rfc9486
Date: Mon, 26 Feb 2024 13:49:21 +0100
Message-Id: <20240226124921.9097-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not really a fix per se, but IPV6_TLV_IOAM is still tagged as "TEMPORARY
IANA allocation for IOAM", while RFC 9486 is available for some time
now. Just update the reference.

Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace")
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 include/uapi/linux/in6.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
index c4c53a9ab959..ff8d21f9e95b 100644
--- a/include/uapi/linux/in6.h
+++ b/include/uapi/linux/in6.h
@@ -145,7 +145,7 @@ struct in6_flowlabel_req {
 #define IPV6_TLV_PADN		1
 #define IPV6_TLV_ROUTERALERT	5
 #define IPV6_TLV_CALIPSO	7	/* RFC 5570 */
-#define IPV6_TLV_IOAM		49	/* TEMPORARY IANA allocation for IOAM */
+#define IPV6_TLV_IOAM		49	/* RFC 9486 */
 #define IPV6_TLV_JUMBO		194
 #define IPV6_TLV_HAO		201	/* home address option */
 

base-commit: 10bfd453da64a057bcfd1a49fb6b271c48653cdb
-- 
2.34.1


