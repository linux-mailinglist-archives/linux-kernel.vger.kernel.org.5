Return-Path: <linux-kernel+bounces-67508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A51856CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5361C2139A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5903513AA3E;
	Thu, 15 Feb 2024 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YU7/lnHs"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC2B13A274
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021662; cv=none; b=bdYzZP5IT4ZSAbl5eK8UcODFg7Z7OL2Qx7YnMoIyNDaLPlqfRDYJQkMMS0XUe8YHmf6/Dc5x679vER0mfayF+pxVM6GZ2Z0pXiC5HEMbCMStqtvT3KgbWk9XAnn9P279XSw88EmfPd25oZmC+9VhmAh1k6Zd1Kj7y3BIcUX9x/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021662; c=relaxed/simple;
	bh=jLl9Z2fTsH6Rmmj0FW2/msC3++4LT5xvr/9S1+KPYzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9kOHivMWBSiwTIOwksTicFVMHh8b9Mi8EKkdhY6ZYSPAZHJ5lliFdGYRGbmQ4W+Xpf6vqhC5s85yDubm38Gdv3n8cJnRs1ghEls7P/wA9V3iUj/LqCPiDKBVt36yxpo+XOLWYX12dHRuRpOT3VW1p33IfOLdYa1nfUnQpxwbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YU7/lnHs; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bba50cd318so880960b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1708021659; x=1708626459; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fl0lbVWFk7esL9ghuxTeB/l0ggA63ROJq7hUF6DPi6w=;
        b=YU7/lnHsQoJeqkvEOK5GYtMOyjHq/z0SfwK9I9VPg+VMiK7yRSgzGQxsBKg71AQ7Lq
         jYipdrdVAYC/6jjWRhrDG4t8MZsh6EVgMuIvSe6TnbQ1kZXC6Eb1M50dyR9S3wuprADV
         WicDfTISCWCdQHeXKmJ/HzolGjD+8UBh45DWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708021659; x=1708626459;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fl0lbVWFk7esL9ghuxTeB/l0ggA63ROJq7hUF6DPi6w=;
        b=e/xtzJWgUYGlCtLCMqQVDtV2vIGtHghqb9Xbc0U/j0jfPeIVR3VKjzMkFVFwfhxi02
         u8K/ea7imLDvU+fmIeJ/JFlH3sKPrJom7O5gtWK2cTDgJX4m1xmGGEqIQ25Ci88nqxN2
         DdRhgFgSyBQGSndL2aTr3Acx5dalkkMumDs4DGeJDUcttBfuW85xt404O3AWlXsJiAAN
         Hp2lDGaKgQjWxxY/XssEP58SsZrBxuF3cTMDUUoHirpcTSHVRb8+Cx1Kc/TDMp6BcBCX
         r1poJq4pJk8ut31jONwFW0vwQUc9Sb0XVAqSI86mxC+HW3WTC+oESZouzxYWSM02N9wg
         ukAw==
X-Forwarded-Encrypted: i=1; AJvYcCUuSkwlFv7k8pFT/LN1M+6pbFfBImFZDK1hQoC7k8dvAtrAenTOutlEsT0liBF8jhmOTilrN+VJNuyNGPYnXnR74Lu8OxNKw+YXl7v9
X-Gm-Message-State: AOJu0YxCIOZu3Uf7aYQIlbP1PGh0TKBwKTu94NdOqrt3CbOfQLAwC/Dz
	m5VV7Ius9nWBs3REk+M9JZqqV66QV6HOPLhHKyAhFKLl2KsHu7gEghsFyom9lQ==
X-Google-Smtp-Source: AGHT+IHmhET1pIJGjsljlBZCoPCqcZ+qIT9ia2lHH5LqZUw/o0RXU9TJFUjekxtmoP5WcjUZzAj/nQ==
X-Received: by 2002:a05:6808:9a3:b0:3c0:326a:9cff with SMTP id e3-20020a05680809a300b003c0326a9cffmr2709373oig.23.1708021659611;
        Thu, 15 Feb 2024 10:27:39 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id mf4-20020a0562145d8400b0068f13038031sm901515qvb.5.2024.02.15.10.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 10:27:39 -0800 (PST)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hangyu Hua <hbh25y@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM ASP 2.0 ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] net: bcmasp: Sanity check is off by one
Date: Thu, 15 Feb 2024 10:27:32 -0800
Message-Id: <20240215182732.1536941-3-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215182732.1536941-1-justin.chen@broadcom.com>
References: <20240215182732.1536941-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004fce4a06116fc8fe"

--0000000000004fce4a06116fc8fe
Content-Transfer-Encoding: 8bit

A sanity check for OOB write is off by one leading to a false positive
when the array is full.

Fixes: 9b90aca97f6d ("net: ethernet: bcmasp: fix possible OOB write in bcmasp_netfilt_get_all_active()")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 29b04a274d07..80245c65cc90 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -535,9 +535,6 @@ int bcmasp_netfilt_get_all_active(struct bcmasp_intf *intf, u32 *rule_locs,
 	int j = 0, i;
 
 	for (i = 0; i < NUM_NET_FILTERS; i++) {
-		if (j == *rule_cnt)
-			return -EMSGSIZE;
-
 		if (!priv->net_filters[i].claimed ||
 		    priv->net_filters[i].port != intf->port)
 			continue;
@@ -547,6 +544,9 @@ int bcmasp_netfilt_get_all_active(struct bcmasp_intf *intf, u32 *rule_locs,
 		    priv->net_filters[i - 1].wake_filter)
 			continue;
 
+		if (j == *rule_cnt)
+			return -EMSGSIZE;
+
 		rule_locs[j++] = priv->net_filters[i].fs.location;
 	}
 
-- 
2.34.1


--0000000000004fce4a06116fc8fe
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
NhTY3E+cXCB11wty89QStajwXdhGJTYEvUgvsq1h8CwJj9w/38ldAQf5WjhPmApYeJR2ewFrBMCM
4lHkdRJ6TDc9nXoEkypUfjJkJHe7Eal06tosh6JpAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGp1c3Rpbi5jaGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIWGeYuaTsnIada5Xx8TR3cheUbgw
DQYJKoZIhvcNAQELBQADggEBAHNQlMqQOFYPYFO71A+8t+qWMmtOdd2iGswSOvpSZ/pmGlfw8ZvY
dRTkl27m37la84AxRkiVMes14JyOZJoMh/g7fbgPlU14eBc6WQWkIA6AmNkduFWTr1pRezkjpeo6
xVmdBLM4VY1TFDYj7S8H2adPuypd62uHMY/MZi+BIUys4uAFA+N3NuUBNjcVZXYPplYxxKEuIFq6
sDL+OV16G+F9CkNMN3txsym8Nnx5WAYZb6+rBUIhMGz70V05xsHQfzvo2s7f0J1tJ5BoRlPPhL0h
VOnWA3h71u9TfSsv+PXVm3P21TfOS2uc1hbzEqyENCP4i5XQ0rv0TmPW42GZ0o4xggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwj8BKLXNpALfemdRAwDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJa8liF1on5AqvMzEvC4z3tONqvhlTUdleCn
0uIV8F3rMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIxNTE4
MjczOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQBnj5Mf/qpR5tfsXrPRC/7xfxQUupgS2aZg0qeYzumBJitkHdqsuYal
4fyRS6zl6z7y+vJjk/heY0KiOBphxsQEwxpPA/kXrWpmsUzqubVUbhZQUkVHjWbTq6M55BeztHf8
2vaRD09l9DfL31MoIVGJGBlDxmv22+5ZnSk/bDQapYG4GGqBZ7E3IRYbE+x4gWwPvMXeTBhTxf56
6Ggv/BFmm7UZit7fXmQ4AaKVQW+x6/gzxkFgcMPjUBmArWZ6JBrbXz3Ro7UL59B/CHbiWCfd7NNa
Wjh5W6tY6SIe1Q6F3/qADRajcLsuTJYO51OS/MpfEtE78zNYZLkczHxb2can
--0000000000004fce4a06116fc8fe--

