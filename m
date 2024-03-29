Return-Path: <linux-kernel+bounces-126150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E818932DA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB948281E73
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5844B14883C;
	Sun, 31 Mar 2024 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MqWRDyHZ"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C525147C66;
	Sun, 31 Mar 2024 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902386; cv=pass; b=gMycmcT7yQzyC5w6VlBqN7Nhpt9+n4SO3mHd8uI3FwUm5TDPNzg9rSlyZo6B5vfhMr3ba/Kc9JPgu5B0kNtrmsTMa4/wfd/gpF6QHgGn4RY7qhxHn8Wnzl9iMuVMqEdep7klStsBHPTTOBYHE1ldHfJf9p42Jjc7r7XAfFPJCeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902386; c=relaxed/simple;
	bh=StGoq54zznjDZKc/Pf7ZGEHHjSofq9BwKnoDbg71mHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MVGSqjDpoiCehvUAFghWNQ9/B+v1drVLXOGNWwzbnvEMfIzIlcz+XEU3bRcoknoHHt8GI+2rZjKhxnMysaxcy68R4raOyr4Ll+0YgPcKCwGs1eBkRiIH38byBwFeOjQFF+sOQIn28xv6miWk2AYLb1Yyvk4yWhASvjps3PgP6zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=fail smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MqWRDyHZ; arc=none smtp.client-ip=205.220.168.131; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=quicinc.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id B507B20892;
	Sun, 31 Mar 2024 18:26:22 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kvvAnr1j93Z7; Sun, 31 Mar 2024 18:26:22 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7A5F120897;
	Sun, 31 Mar 2024 18:26:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7A5F120897
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 6EA1B80004E;
	Sun, 31 Mar 2024 18:26:20 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:26:20 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:28 +0000
X-sender: <linux-wireless+bounces-5623-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAZJDp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBkAAAAiooAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 25774
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=linux-wireless+bounces-5623-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 1BFFD20270
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MqWRDyHZ"
X-Original-To: linux-wireless@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711744055; cv=none; b=QElk8gh858jXIFAdKlEuEgd3eVX56pPJAdglEopJNNxzYbipooWiEv/PqjqSKNJX7szBg5463RkjYuMIFLmSN/Ou9uBmDynlcHfx5AEJlfKRK/mNw9W6L/c+/rBZAmUHwMVBUaIgX3bU2iUOnez4WR515OkHk62fiWwPWHXHpuE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711744055; c=relaxed/simple;
	bh=StGoq54zznjDZKc/Pf7ZGEHHjSofq9BwKnoDbg71mHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eJtor+Q17vwPqmCIL02xw4u+Bi4wBHT87v9P/pqgBhmxl6pYTgQ81YAkfLIAUT8j48XiaB+ioD/9r1+RKDvViIi2473m2kagM47cxHL3dDLLi14FIMuwk/FIbu7QyxSo1o5JvCc2ZVe5smktXLdG7KyQLfqFSaQASJvJOlWUPIk=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MqWRDyHZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=sXcof/W6pLniDYlgtOd09vD4vb8NPmLp0ZyN24gIjo8
	=; b=MqWRDyHZwMIJZ0kLPPl52i6v0DHRqnHncfSw5/W4sxK6MlH+8QtxFXROHG0
	mr0V2eCmeiT6mM10v+MmDedAffgLKny5H30YaaqejZl7RBcqZfM6RVjtJQtNY+Mw
	Aseq2Nt3TMm3dKjSVPSGEt1K487uZxLoQROvJt3DDkJ64y7TDmxgb8Nx8cEk0QjP
	ml11lNWxp029LFKIq4C8LlU6Svxt9upq/TO2LEfuq9Vtw2s3XfEN4ERjSywlqRBq
	zH8bW3tomi/NX1Am8UzpSxezqR6s3ssW49WqbVKbJJbT22ki72BCzOBUOYfOTvBC
	WO4X+kQOP4FuUmJpLgG6AJ+PEsQ==
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 29 Mar 2024 13:27:18 -0700
Subject: [PATCH 2/2] wifi: mac80211: Add missing return value documentation
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240329-mac80211-kdoc-retval-v1-2-5e4d1ad6c250@quicinc.com>
References: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
In-Reply-To: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Randy Dunlap
	<rdunlap@infradead.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xhTppq_Un9CZqBajTwh1HK45NHrZmMzS
X-Proofpoint-ORIG-GUID: xhTppq_Un9CZqBajTwh1HK45NHrZmMzS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290183
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

kernel-doc is reporting some warnings, so fix them:

% scripts/kernel-doc -Wall -Werror -none include/net/mac80211.h
include/net/mac80211.h:2056: warning: No description found for return value of 'wdev_to_ieee80211_vif'
include/net/mac80211.h:2066: warning: No description found for return value of 'ieee80211_vif_to_wdev'
include/net/mac80211.h:5603: warning: No description found for return value of 'ieee80211_beacon_cntdwn_is_complete'
include/net/mac80211.h:5968: warning: No description found for return value of 'ieee80211_gtk_rekey_add'
include/net/mac80211.h:6350: warning: No description found for return value of 'ieee80211_find_sta_by_link_addrs'
include/net/mac80211.h:6478: warning: No description found for return value of 'ieee80211_txq_airtime_check'
include/net/mac80211.h:6981: warning: No description found for return value of 'rate_control_set_rates'
include/net/mac80211.h:7142: warning: No description found for return value of 'ieee80211_tx_prepare_skb'
include/net/mac80211.h:7156: warning: No description found for return value of 'ieee80211_parse_tx_radiotap'
include/net/mac80211.h:7277: warning: No description found for return value of 'ieee80211_tx_dequeue'
include/net/mac80211.h:7292: warning: No description found for return value of 'ieee80211_tx_dequeue_ni'
include/net/mac80211.h:7324: warning: No description found for return value of 'ieee80211_next_txq'
include/net/mac80211.h:7405: warning: No description found for return value of 'ieee80211_txq_may_transmit'
include/net/mac80211.h:7466: warning: No description found for return value of 'ieee80211_calc_rx_airtime'
include/net/mac80211.h:7480: warning: No description found for return value of 'ieee80211_calc_tx_airtime'
include/net/mac80211.h:7528: warning: No description found for return value of 'ieee80211_is_tx_data'
include/net/mac80211.h:7562: warning: No description found for return value of 'ieee80211_set_active_links'
17 warnings as Errors

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 include/net/mac80211.h | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index e6a11a982ca8..8984ac4359b8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2049,7 +2049,7 @@ static inline bool ieee80211_vif_is_mesh(struct ieee80211_vif *vif)
  * This can be used by mac80211 drivers with direct cfg80211 APIs
  * (like the vendor commands) that get a wdev.
  *
- * Note that this function may return %NULL if the given wdev isn't
+ * Return: pointer to the wdev, or %NULL if the given wdev isn't
  * associated with a vif that the driver knows about (e.g. monitor
  * or AP_VLAN interfaces.)
  */
@@ -2062,6 +2062,8 @@ struct ieee80211_vif *wdev_to_ieee80211_vif(struct wireless_dev *wdev);
  * This can be used by mac80211 drivers with direct cfg80211 APIs
  * (like the vendor commands) that needs to get the wdev for a vif.
  * This can also be useful to get the netdev associated to a vif.
+ *
+ * Return: pointer to the wdev
  */
 struct wireless_dev *ieee80211_vif_to_wdev(struct ieee80211_vif *vif);
 
@@ -5597,7 +5599,7 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id);
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
  * @link_id: valid link_id during MLO or 0 for non-MLO
  *
- * This function returns whether the countdown reached zero.
+ * Return: %true if the countdown reached 1, %false otherwise
  */
 bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif,
 					 unsigned int link_id);
@@ -5942,8 +5944,8 @@ void ieee80211_remove_key(struct ieee80211_key_conf *keyconf);
  * key(s) will be available. These will be needed by mac80211 for proper
  * RX processing, so this function allows setting them.
  *
- * The function returns the newly allocated key structure, which will
- * have similar contents to the passed key configuration but point to
+ * Return: the newly allocated key structure, which will have
+ * similar contents to the passed key configuration but point to
  * mac80211-owned memory. In case of errors, the function returns an
  * ERR_PTR(), use IS_ERR() etc.
  *
@@ -6342,6 +6344,8 @@ struct ieee80211_sta *ieee80211_find_sta_by_ifaddr(struct ieee80211_hw *hw,
  *	may be %NULL if the link ID is not needed
  *
  * Obtain the STA by link address, must use RCU protection.
+ *
+ * Return: pointer to STA if found, otherwise %NULL.
  */
 struct ieee80211_sta *
 ieee80211_find_sta_by_link_addrs(struct ieee80211_hw *hw,
@@ -6471,8 +6475,8 @@ void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
  * @hw: pointer obtained from ieee80211_alloc_hw()
  * @txq: pointer obtained from station or virtual interface
  *
- * Return true if the AQL's airtime limit has not been reached and the txq can
- * continue to send more packets to the device. Otherwise return false.
+ * Return: %true if the AQL's airtime limit has not been reached and the txq can
+ * continue to send more packets to the device. Otherwise return %false.
  */
 bool
 ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
@@ -6975,6 +6979,8 @@ bool rate_usable_index_exists(struct ieee80211_supported_band *sband,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @pubsta: &struct ieee80211_sta pointer to the target destination.
  * @rates: new tx rate set to be used for this station.
+ *
+ * Return: 0 on success. An error code otherwise.
  */
 int rate_control_set_rates(struct ieee80211_hw *hw,
 			   struct ieee80211_sta *pubsta,
@@ -7135,6 +7141,8 @@ void ieee80211_report_wowlan_wakeup(struct ieee80211_vif *vif,
  * @band: the band to transmit on
  * @sta: optional pointer to get the station to send the frame to
  *
+ * Return: %true if the skb was prepared, %false otherwise
+ *
  * Note: must be called under RCU lock
  */
 bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw,
@@ -7151,6 +7159,8 @@ bool ieee80211_tx_prepare_skb(struct ieee80211_hw *hw,
  *
  * @skb: packet injected by userspace
  * @dev: the &struct device of this 802.11 device
+ *
+ * Return: %true if the radiotap header was parsed, %false otherwise
  */
 bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
 				 struct net_device *dev);
@@ -7260,7 +7270,7 @@ void ieee80211_unreserve_tid(struct ieee80211_sta *sta, u8 tid);
  * @txq: pointer obtained from station or virtual interface, or from
  *	ieee80211_next_txq()
  *
- * Returns the skb if successful, %NULL if no frame was available.
+ * Return: the skb if successful, %NULL if no frame was available.
  *
  * Note that this must be called in an rcu_read_lock() critical section,
  * which can only be released after the SKB was handled. Some pointers in
@@ -7286,6 +7296,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @txq: pointer obtained from station or virtual interface, or from
  *	ieee80211_next_txq()
+ *
+ * Return: the skb if successful, %NULL if no frame was available.
  */
 static inline struct sk_buff *ieee80211_tx_dequeue_ni(struct ieee80211_hw *hw,
 						      struct ieee80211_txq *txq)
@@ -7317,7 +7329,7 @@ void ieee80211_handle_wake_tx_queue(struct ieee80211_hw *hw,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @ac: AC number to return packets from.
  *
- * Returns the next txq if successful, %NULL if no queue is eligible. If a txq
+ * Return: the next txq if successful, %NULL if no queue is eligible. If a txq
  * is returned, it should be returned with ieee80211_return_txq() after the
  * driver has finished scheduling it.
  */
@@ -7400,6 +7412,8 @@ ieee80211_return_txq(struct ieee80211_hw *hw, struct ieee80211_txq *txq,
  *
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @txq: pointer obtained from station or virtual interface
+ *
+ * Return: %true if transmission is allowed, %false otherwise
  */
 bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 				struct ieee80211_txq *txq);
@@ -7460,6 +7474,8 @@ void ieee80211_nan_func_match(struct ieee80211_vif *vif,
  * @status: &struct ieee80211_rx_status containing the transmission rate
  *          information.
  * @len: frame length in bytes
+ *
+ * Return: the airtime estimate
  */
 u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
 			      struct ieee80211_rx_status *status,
@@ -7474,6 +7490,8 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
  * @hw: pointer as obtained from ieee80211_alloc_hw()
  * @info: &struct ieee80211_tx_info of the frame.
  * @len: frame length in bytes
+ *
+ * Return: the airtime estimate
  */
 u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
 			      struct ieee80211_tx_info *info,
@@ -7523,6 +7541,8 @@ ieee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
  * hardware encapsulation enabled are data frames.
  *
  * @skb: the frame to be transmitted.
+ *
+ * Return: %true if @skb is a data frame, %false otherwise
  */
 static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
 {
@@ -7558,6 +7578,8 @@ static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
  *  - change_sta_links(0x10) for each affected STA (the AP)
  *  - assign_vif_chanctx(link_id=4)
  *  - change_vif_links(0x10)
+ *
+ * Return: 0 on success. An error code otherwise.
  */
 int ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links);
 

-- 
2.42.0



