Return-Path: <linux-kernel+bounces-39388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C948A83CFC2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF95298668
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3402311725;
	Thu, 25 Jan 2024 22:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lz/raEtD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDDF12E4E;
	Thu, 25 Jan 2024 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223367; cv=none; b=EFkeVQQsNnIMCPAIjp8rBbw+pE/iJJARWJVQD257RnNX4yP6fTrMP3+rIedjQ0QyAUfD+eHZxGt792P/5nQHjBFNWE5aR3MkRKNujbxlGyGGwt8SRRQgElJ2aTBD3/Kg2/mw4CPSuzYU2jVNZICVa8DJe2+NbCw/oJcEv7jlQH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223367; c=relaxed/simple;
	bh=6nh1lQqxDDbt+H3HWELxmrrcExTyqD3eFbOHlmfRpPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=tLPL7KrvKMrooaFbpt42bs4OmB+73Umpo4cDuucSdtTNSNFn8vbtbADLWlQ/pl1au1nsvuM5XPIfyNcfyelYUo7RbBA3cWFGp3YGbzhhYwmSBd/3kR0iUbVhgiuPJoDos+6y9OezcnaxKvi/n4Cw16/aRhtx2IuyEnFZWFo95aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lz/raEtD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PLa7YR029658;
	Thu, 25 Jan 2024 22:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=HCh
	UC4x+5CmbG4DO8gA69u/ch2BhDGAtrM7ibqqCR7g=; b=lz/raEtDrUJH7K1hJF2
	oGk7/RreE4ryUvfoJMQG5lHMXHA9XdSX4sTMn4Ro1Y3+wlrgdt4W+O/RHpzFXeJt
	1Me8YDoD5PjxVWfodM8iQS45+1s0cI4X+U8pTQKPW6GWhWoT8+ZSMDijbXEfiL6B
	g7BP29aKyEPox8EV/+UiR627xDjzVYiVggrRQcuAmKjssOFjhI+VDXOH0rOsSw+3
	w7PhehUuKUvvwL0LyDh0M7fUf81Tcrg/WxFyMQnNf/tpoMzd68DRI+xnfjzDLQkJ
	0zMNUqArZTAG+9QOrdQoiI8qMSemlpco2MmDSg9x6UzB38HwaD4C9Raqt3EvEmnu
	MOg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vuypkg50p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 22:55:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PMtoYs032061
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 22:55:50 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 14:55:50 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 25 Jan 2024 14:55:47 -0800
Subject: [PATCH] Revert "nl80211/cfg80211: Specify band specific min RSSI
 thresholds with sched scan"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240125-for-next-v1-1-fd79e01c6c09@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPLmsmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQyNT3bT8It281IoS3SSLxGTzlGSjpBRDcyWg8oKi1LTMCrBR0bG1tQD
 C8ZeGWgAAAA==
To: Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Lin Ma <linma@zju.edu.cn>,
        Vamsi Krishna
	<quic_vamsin@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SbSDd9gSN-iC8tgYkN9t7HMrhw1qH1l2
X-Proofpoint-GUID: SbSDd9gSN-iC8tgYkN9t7HMrhw1qH1l2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=652 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401250165

This *mostly* reverts commit 1e1b11b6a1111cd9e8af1fd6ccda270a9fa3eacf.

During the review of a new patch [1] it was observed that the
functionality being modified was not actually being used by any
in-tree driver. Further research determined that the functionality was
originally introduced to support a new Android interface, but that
interface was subsequently abandoned. Since the functionality has
apparently never been used, remove it. However, to mantain the
sanctity of the UABI, keep the nl80211.h assignments, but clearly mark
them as obsolete.

Cc: Lin Ma <linma@zju.edu.cn>
Cc: Vamsi Krishna <quic_vamsin@quicinc.com>
Link: https://lore.kernel.org/linux-wireless/20240119151201.8670-1-linma@zju.edu.cn/ [1]
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 include/net/cfg80211.h       |  8 -------
 include/uapi/linux/nl80211.h | 16 ++++---------
 net/wireless/nl80211.c       | 55 --------------------------------------------
 3 files changed, 4 insertions(+), 75 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index cf79656ce09c..65df03a49439 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2695,19 +2695,11 @@ static inline void get_random_mask_addr(u8 *buf, const u8 *addr, const u8 *mask)
  * @bssid: BSSID to be matched; may be all-zero BSSID in case of SSID match
  *	or no match (RSSI only)
  * @rssi_thold: don't report scan results below this threshold (in s32 dBm)
- * @per_band_rssi_thold: Minimum rssi threshold for each band to be applied
- *	for filtering out scan results received. Drivers advertise this support
- *	of band specific rssi based filtering through the feature capability
- *	%NL80211_EXT_FEATURE_SCHED_SCAN_BAND_SPECIFIC_RSSI_THOLD. These band
- *	specific rssi thresholds take precedence over rssi_thold, if specified.
- *	If not specified for any band, it will be assigned with rssi_thold of
- *	corresponding matchset.
  */
 struct cfg80211_match_set {
 	struct cfg80211_ssid ssid;
 	u8 bssid[ETH_ALEN];
 	s32 rssi_thold;
-	s32 per_band_rssi_thold[NUM_NL80211_BANDS];
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 1ccdcae24372..1b1fd3187446 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4455,14 +4455,7 @@ enum nl80211_reg_rule_attr {
  *	value as specified by &struct nl80211_bss_select_rssi_adjust.
  * @NL80211_SCHED_SCAN_MATCH_ATTR_BSSID: BSSID to be used for matching
  *	(this cannot be used together with SSID).
- * @NL80211_SCHED_SCAN_MATCH_PER_BAND_RSSI: Nested attribute that carries the
- *	band specific minimum rssi thresholds for the bands defined in
- *	enum nl80211_band. The minimum rssi threshold value(s32) specific to a
- *	band shall be encapsulated in attribute with type value equals to one
- *	of the NL80211_BAND_* defined in enum nl80211_band. For example, the
- *	minimum rssi threshold value for 2.4GHZ band shall be encapsulated
- *	within an attribute of type NL80211_BAND_2GHZ. And one or more of such
- *	attributes will be nested within this attribute.
+ * @NL80211_SCHED_SCAN_MATCH_PER_BAND_RSSI: Obsolete
  * @NL80211_SCHED_SCAN_MATCH_ATTR_MAX: highest scheduled scan filter
  *	attribute number currently defined
  * @__NL80211_SCHED_SCAN_MATCH_ATTR_AFTER_LAST: internal use
@@ -4475,7 +4468,7 @@ enum nl80211_sched_scan_match_attr {
 	NL80211_SCHED_SCAN_MATCH_ATTR_RELATIVE_RSSI,
 	NL80211_SCHED_SCAN_MATCH_ATTR_RSSI_ADJUST,
 	NL80211_SCHED_SCAN_MATCH_ATTR_BSSID,
-	NL80211_SCHED_SCAN_MATCH_PER_BAND_RSSI,
+	NL80211_SCHED_SCAN_MATCH_PER_BAND_RSSI, /* obsolete */
 
 	/* keep last */
 	__NL80211_SCHED_SCAN_MATCH_ATTR_AFTER_LAST,
@@ -6410,8 +6403,7 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_AP_PMKSA_CACHING: Driver/device supports PMKSA caching
  *	(set/del PMKSA operations) in AP mode.
  *
- * @NL80211_EXT_FEATURE_SCHED_SCAN_BAND_SPECIFIC_RSSI_THOLD: Driver supports
- *	filtering of sched scan results using band specific RSSI thresholds.
+ * @NL80211_EXT_FEATURE_SCHED_SCAN_BAND_SPECIFIC_RSSI_THOLD: Obsolete
  *
  * @NL80211_EXT_FEATURE_STA_TX_PWR: This driver supports controlling tx power
  *	to a station.
@@ -6561,7 +6553,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_ENABLE_FTM_RESPONDER,
 	NL80211_EXT_FEATURE_AIRTIME_FAIRNESS,
 	NL80211_EXT_FEATURE_AP_PMKSA_CACHING,
-	NL80211_EXT_FEATURE_SCHED_SCAN_BAND_SPECIFIC_RSSI_THOLD,
+	NL80211_EXT_FEATURE_SCHED_SCAN_BAND_SPECIFIC_RSSI_THOLD, /* obsolete */
 	NL80211_EXT_FEATURE_EXT_KEY_ID,
 	NL80211_EXT_FEATURE_STA_TX_PWR,
 	NL80211_EXT_FEATURE_SAE_OFFLOAD,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 60877b532993..187c2f644b55 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -905,23 +905,12 @@ nl80211_rekey_policy[NUM_NL80211_REKEY_DATA] = {
 	[NL80211_REKEY_DATA_AKM] = { .type = NLA_U32 },
 };
 
-static const struct nla_policy
-nl80211_match_band_rssi_policy[NUM_NL80211_BANDS] = {
-	[NL80211_BAND_2GHZ] = { .type = NLA_S32 },
-	[NL80211_BAND_5GHZ] = { .type = NLA_S32 },
-	[NL80211_BAND_6GHZ] = { .type = NLA_S32 },
-	[NL80211_BAND_60GHZ] = { .type = NLA_S32 },
-	[NL80211_BAND_LC]    = { .type = NLA_S32 },
-};
-
 static const struct nla_policy
 nl80211_match_policy[NL80211_SCHED_SCAN_MATCH_ATTR_MAX + 1] = {
 	[NL80211_SCHED_SCAN_MATCH_ATTR_SSID] = { .type = NLA_BINARY,
 						 .len = IEEE80211_MAX_SSID_LEN },
 	[NL80211_SCHED_SCAN_MATCH_ATTR_BSSID] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
 	[NL80211_SCHED_SCAN_MATCH_ATTR_RSSI] = { .type = NLA_U32 },
-	[NL80211_SCHED_SCAN_MATCH_PER_BAND_RSSI] =
-		NLA_POLICY_NESTED(nl80211_match_band_rssi_policy),
 };
 
 static const struct nla_policy
@@ -9480,41 +9469,6 @@ nl80211_parse_sched_scan_plans(struct wiphy *wiphy, int n_plans,
 	return 0;
 }
 
-static int
-nl80211_parse_sched_scan_per_band_rssi(struct wiphy *wiphy,
-				       struct cfg80211_match_set *match_sets,
-				       struct nlattr *tb_band_rssi,
-				       s32 rssi_thold)
-{
-	struct nlattr *attr;
-	int i, tmp, ret = 0;
-
-	if (!wiphy_ext_feature_isset(wiphy,
-		    NL80211_EXT_FEATURE_SCHED_SCAN_BAND_SPECIFIC_RSSI_THOLD)) {
-		if (tb_band_rssi)
-			ret = -EOPNOTSUPP;
-		else
-			for (i = 0; i < NUM_NL80211_BANDS; i++)
-				match_sets->per_band_rssi_thold[i] =
-					NL80211_SCAN_RSSI_THOLD_OFF;
-		return ret;
-	}
-
-	for (i = 0; i < NUM_NL80211_BANDS; i++)
-		match_sets->per_band_rssi_thold[i] = rssi_thold;
-
-	nla_for_each_nested(attr, tb_band_rssi, tmp) {
-		enum nl80211_band band = nla_type(attr);
-
-		if (band < 0 || band >= NUM_NL80211_BANDS)
-			return -EINVAL;
-
-		match_sets->per_band_rssi_thold[band] =	nla_get_s32(attr);
-	}
-
-	return 0;
-}
-
 static struct cfg80211_sched_scan_request *
 nl80211_parse_sched_scan(struct wiphy *wiphy, struct wireless_dev *wdev,
 			 struct nlattr **attrs, int max_match_sets)
@@ -9789,15 +9743,6 @@ nl80211_parse_sched_scan(struct wiphy *wiphy, struct wireless_dev *wdev,
 			if (rssi)
 				request->match_sets[i].rssi_thold =
 					nla_get_s32(rssi);
-
-			/* Parse per band RSSI attribute */
-			err = nl80211_parse_sched_scan_per_band_rssi(wiphy,
-				&request->match_sets[i],
-				tb[NL80211_SCHED_SCAN_MATCH_PER_BAND_RSSI],
-				request->match_sets[i].rssi_thold);
-			if (err)
-				goto out_free;
-
 			i++;
 		}
 

---
base-commit: 3fbf61207c66ff7ac9b60ab76d4bfd239f97e973
change-id: 20240125-for-next-b8ac7dc2bd17


