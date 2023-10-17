Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7B57CCD35
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344139AbjJQUDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjJQUBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:01:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E756102;
        Tue, 17 Oct 2023 13:01:48 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HJmFNJ030232;
        Tue, 17 Oct 2023 20:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=hz50xZpShR85GDOgNBvvNRkbxL4fXtXTOG3LlEUNGAE=;
 b=at0IJ7MWH7r/cCVqaIPx/w07JO4L7x9aDxjLsllJW83fiHu8y09UxMq40Bxj8yHCWIgn
 W++FZ93E9h7HamFXX/RmiEwB8iExw0HufSnB6mWOaOAm/D72XWT38MHa485Zu6uRdaLQ
 VLJY2Y+t9iAlbV0c/T5XSmtDFHCAF4COrG9bAH4nkZUoPBOdsgXHj0BeiB9RuhK/SKk1
 Mpv30agWct+rv40KOiWHhAJEPOcjknQmuYm8TW+jlKVJ5wfEBwnzsal+L2fDH9dkqXRz
 9J2xeZ7OBtrB9kJjAcSZ8udHRkbwtnLnp7WC58ZTFnsK2tmJfh+Af4puTSDd5v2oso0K mA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsb7xjxt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 20:01:20 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HK1JBQ004886
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 20:01:19 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 17 Oct 2023 13:01:18 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v9 00/34] Introduce QC USB SND audio offloading support
Date:   Tue, 17 Oct 2023 13:00:35 -0700
Message-ID: <20231017200109.11407-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KlLlYD99lFj3aRSpLio7vLA9Y9OiCGEc
X-Proofpoint-GUID: KlLlYD99lFj3aRSpLio7vLA9Y9OiCGEc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170170
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several Qualcomm based chipsets can support USB audio offloading to a
dedicated audio DSP, which can take over issuing transfers to the USB
host controller.  The intention is to reduce the load on the main
processors in the SoC, and allow them to be placed into lower power modes.
There are several parts to this design:
  1. Adding ASoC binding layer
  2. Create a USB backend for Q6DSP
  3. Introduce XHCI interrupter support
  4. Create vendor ops for the USB SND driver

      USB                          |            ASoC
--------------------------------------------------------------------
                                   |  _________________________
                                   | |sm8250 platform card     |
                                   | |_________________________|
                                   |         |           |
                                   |      ___V____   ____V____
                                   |     |Q6USB   | |Q6AFE    |  
                                   |     |"codec" | |"cpu"    |
                                   |     |________| |_________|
                                   |         ^  ^        ^
                                   |         |  |________|
                                   |      ___V____    |
                                   |     |SOC-USB |   |
   ________       ________               |        |   |
  |USB SND |<--->|QC offld|<------------>|________|   |
  |(card.c)|     |        |<----------                |
  |________|     |________|___     | |                |
      ^               ^       |    | |    ____________V_________
      |               |       |    | |   |APR/GLINK             |
   __ V_______________V_____  |    | |   |______________________|
  |USB SND (endpoint.c)     | |    | |              ^
  |_________________________| |    | |              |
              ^               |    | |   ___________V___________
              |               |    | |->|audio DSP              |
   ___________V_____________  |    |    |_______________________|
  |XHCI HCD                 |<-    |
  |_________________________|      |


Adding ASoC binding layer:
soc-usb: Intention is to treat a USB port similar to a headphone jack.
The port is always present on the device, but cable/pin status can be
enabled/disabled.  Expose mechanisms for USB backend ASoC drivers to
communicate with USB SND.

Create a USB backend for Q6DSP:
q6usb: Basic backend driver that will be responsible for maintaining the
resources needed to initiate a playback stream using the Q6DSP.  Will
be the entity that checks to make sure the connected USB audio device
supports the requested PCM format.  If it does not, the PCM open call will
fail, and userpsace ALSA can take action accordingly.

Introduce XHCI interrupter support:
XHCI HCD supports multiple interrupters, which allows for events to be routed
to different event rings.  This is determined by "Interrupter Target" field
specified in Section "6.4.1.1 Normal TRB" of the XHCI specification.

Events in the offloading case will be routed to an event ring that is assigned
to the audio DSP.

Create vendor ops for the USB SND driver:
qc_audio_offload: This particular driver has several components associated
with it:
- QMI stream request handler
- XHCI interrupter and resource management
- audio DSP memory management

When the audio DSP wants to enable a playback stream, the request is first
received by the ASoC platform sound card.  Depending on the selected route,
ASoC will bring up the individual DAIs in the path.  The Q6USB backend DAI
will send an AFE port start command (with enabling the USB playback path), and
the audio DSP will handle the request accordingly.

Part of the AFE USB port start handling will have an exchange of control
messages using the QMI protocol.  The qc_audio_offload driver will populate the
buffer information:
- Event ring base address
- EP transfer ring base address

and pass it along to the audio DSP.  All endpoint management will now be handed
over to the DSP, and the main processor is not involved in transfers.

Overall, implementing this feature will still expose separate sound card and PCM
devices for both the platorm card and USB audio device:
 0 [SM8250MTPWCD938]: sm8250 - SM8250-MTP-WCD9380-WSA8810-VA-D
                      SM8250-MTP-WCD9380-WSA8810-VA-DMIC
 1 [Audio          ]: USB-Audio - USB Audio
                      Generic USB Audio at usb-xhci-hcd.1.auto-1.4, high speed

This is to ensure that userspace ALSA entities can decide which route to take
when executing the audio playback.  In the above, if card#1 is selected, then
USB audio data will take the legacy path over the USB PCM drivers, etc...

This feature was validated using:
- tinymix: set/enable the multimedia path to route to USB backend
- tinyplay: issue playback on platform card

Changelog
--------------------------------------------
Changes in v9:
- Fixed the dt binding check issue with regards to num-hc-interrupters.

Changes in v8:
- Cleaned up snd_soc_usb_find_priv_data() based on Mark's feedback.  Removed some of
the duplicate looping code that was present on previous patches.  Also renamed the API.
- Integrated Mathias' suggestions on his new sideband changes:
https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters
- Addressed some of Mathias' fixme tags, such as:
 - Resetting transfer ring dequeue/enqueue pointers
 - Issuing stop endpoint command during ep removal
 - Reset ERDP properly to first segment ring during interrupter removal. (this is currently
   just being cleared to 0, but should be pointing to a valid segment if controller is still
   running.

Changes in v7:
- Fixed dt check error for q6usb bindings
- Updated q6usb property from qcom,usb-audio-intr-num --> qcom,usb-audio-intr-idx
- Removed separate DWC3 HC interrupters num property, and place limits to XHCI one.
- Modified xhci_ring_to_sgtable() to use assigned IOVA/DMA address to fetch pages, as
it is not ensured event ring allocated is always done in the vmalloc range.

Changes in v6:
- Fixed limits and description on several DT bindings (XHCI and Q6USB)
- Fixed patch subjects to follow other ALSA/ASoC notations.

USB SND
- Addressed devices which expose multiple audio (UAC) interfaces.  These devices will
create a single USB sound card with multiple audio streams, and receive multiple
interface probe routines.  QC offload was not properly considering cases with multiple
probe calls.
- Renamed offload module name and kconfig to fit within the SND domain.
- Renamed attach/detach endpoint API to keep the hw_params notation.

Changes in v5:
- Removed some unnescessary files that were included
- Fixed some typos mentioned
- Addressed dt-binding issues and added hc-interrupters definition to usb-xhci.yaml

XHCI:
- Moved secondary skip events API to xhci-ring and updated implementation
   - Utilized existing XHCI APIs, such as inc_deq and xhci_update_erst_dequeue()

USB SND
- Renamed and reworked the APIs in "sound: usb: Export USB SND APIs for modules" patch to
include suggestions to utilize snd_usb_hw_params/free and to avoid generic naming.
- Added a resume_cb() op for completion sake.
- Addressed some locking concerns with regards to when registering for platform hooks.
- Added routine to disconnect all offloaded devices during module unbind.

ASoC
- Replaced individual PCM parameter arguments in snd_soc_usb_connect() with new
snd_soc_usb_device structure to pass along PCM info.
- Modified snd_jack set report to notify HEADPHONE event, as we do not support record path.

Changes in v4:
- Rebased to xhci/for-usb-next
- Addressed some dt-bindings comments

XHCI:
- Pulled in latest changes from Mathias' feature_interrupters branch:
https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters

- Fixed commit text and signage for the XHCI sideband/interrupter related changes
- Added some logic to address the FIXME tags mentioned throughout the commits, such
as handling multi segment rings and building the SGT, locking concerns, and ep
cleanup operations.
- Removed some fixme tags for conditions that may not be needed/addressed.
- Repurposed the new endpoint stop sync API to be utilized in other places.
- Fixed potential compile issue if XHCI sideband config is not defined.

ASoC:
- Added sound jack control into the Q6USB driver.  Allows for userpsace to know when
an offload capable device is connected.

USB SND:
- Avoided exporting _snd_pcm_hw_param_set based on Takashi's recommendation.
- Split USB QMI packet header definitions into a separate commit.  This is used to
properly allow the QMI interface driver to parse and route QMI packets accordingly
- Added a "depends on" entry when enabling QC audio offload to avoid compile time
issues.

Changes in v3:
- Changed prefix from RFC to PATCH
- Rebased entire series to usb-next
- Updated copyright years

XHCI:
- Rebased changes on top of XHCI changes merged into usb-next, and only added
changes that were still under discussion.
- Added change to read in the "num-hc-interrupters" device property.

ASoC:
- qusb6 USB backend
  - Incorporated suggestions to fetch iommu information with existing APIs
  - Added two new sound kcontrols to fetch offload status and offload device
    selection.
    - offload status - will return the card and pcm device in use
        tinymix -D 0 get 1 --> 1, 0 (offload in progress on card#1 pcm#0)

    - device selection - set the card and pcm device to enable offload on. Ex.:
        tinymix -D 0 set 1 2 0  --> sets offload on card#2 pcm#0
                                    (this should be the USB card)

USB SND:
- Fixed up some locking related concerns for registering platform ops.
   - Moved callbacks under the register_mutex, so that 
- Modified APIs to properly pass more information about the USB SND device, so
that the Q6USB backend can build a device list/map, in order to monitor offload
status and device selection.

Changes in v2:

XHCI:
- Replaced XHCI and HCD changes with Mathias' XHCI interrupter changes
in his tree:
https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters

Adjustments made to Mathias' changes:
  - Created xhci-intr.h to export/expose interrupter APIs versus exposing xhci.h.
    Moved dependent structures to this file as well. (so clients can parse out
    information from "struct xhci_interrupter")
  - Added some basic locking when requesting interrupters.
  - Fixed up some sanity checks.
  - Removed clearing of the ERSTBA during freeing of the interrupter. (pending
    issue where SMMU fault occurs if DMA addr returned is 64b - TODO)

- Clean up pending events in the XHCI secondary interrupter.  While testing USB
bus suspend, it was seen that on bus resume, the xHCI HC would run into a command
timeout.
- Added offloading APIs to xHCI to fetch transfer and event ring information.

ASoC:
- Modified soc-usb to allow for multiple USB port additions.  For this to work,
the USB offload driver has to have a reference to the USB backend by adding
a "usb-soc-be" DT entry to the device saved into XHCI sysdev.
- Created separate dt-bindings for defining USB_RX port.
- Increased APR timeout to accommodate the situation where the AFE port start
command could be delayed due to having to issue a USB bus resume while
handling the QMI stream start command.

USB SND:
- Added a platform ops during usb_audio_suspend().  This allows for the USB
offload driver to halt the audio stream when system enters PM suspend.  This
ensures the audio DSP is not issuing transfers on the USB bus.
- Do not override platform ops if they are already populated.
- Introduce a shared status variable between the USB offload and USB SND layers,
to ensure that only one path is active at a time.  If the USB bus is occupied,
then userspace is notified that the path is busy.

Mathias Nyman (4):
  xhci: split free interrupter into separate remove and free parts
  xhci: add support to allocate several interrupters
  xhci: add helper to stop endpoint and wait for completion
  xhci: sideband: add initial api to register a sideband entity

Wesley Cheng (30):
  usb: host: xhci-mem: Cleanup pending secondary event ring events
  usb: host: xhci-mem: Allow for interrupter clients to choose specific
    index
  ASoC: Add SOC USB APIs for adding an USB backend
  ASoC: dt-bindings: qcom,q6dsp-lpass-ports: Add USB_RX port
  ASoC: qcom: qdsp6: Introduce USB AFE port to q6dsp
  ASoC: qdsp6: q6afe: Increase APR timeout
  ASoC: qcom: qdsp6: Add USB backend ASoC driver for Q6
  ALSA: usb-audio: Introduce USB SND platform op callbacks
  ALSA: usb-audio: Export USB SND APIs for modules
  dt-bindings: usb: xhci: Add num-hc-interrupters definition
  dt-bindings: usb: dwc3: Limit num-hc-interrupters definition
  usb: dwc3: Specify maximum number of XHCI interrupters
  usb: host: xhci-plat: Set XHCI max interrupters if property is present
  ALSA: usb-audio: qcom: Add USB QMI definitions
  ALSA: usb-audio: qcom: Introduce QC USB SND offloading support
  ALSA: usb-audio: Check for support for requested audio format
  ASoC: usb: Add PCM format check API for USB backend
  ASoC: qcom: qdsp6: Ensure PCM format is supported by USB audio device
  ALSA: usb-audio: Prevent starting of audio stream if in use
  ASoC: dt-bindings: Add Q6USB backend
  ASoC: dt-bindings: Update example for enabling USB offload on SM8250
  ASoC: qcom: qdsp6: q6afe: Split USB AFE dev_token param into separate
    API
  ALSA: usb-audio: qcom: Populate PCM and USB chip information
  ASoC: qcom: qdsp6: Add support to track available USB PCM devices
  ASoC: qcom: qdsp6: Add SND kcontrol to select offload device
  ASoC: qcom: qdsp6: Add SND kcontrol for fetching offload status
  ASoC: qcom: qdsp6: Add headphone jack for offload connection status
  ALSA: usb-audio: qcom: Use card and PCM index from QMI request
  ALSA: usb-audio: Allow for rediscovery of connected USB SND devices
  ASoC: usb: Rediscover USB SND devices on USB port add

 .../devicetree/bindings/sound/qcom,q6usb.yaml |   55 +
 .../bindings/sound/qcom,sm8250.yaml           |   15 +
 .../devicetree/bindings/usb/snps,dwc3.yaml    |    4 +
 .../devicetree/bindings/usb/usb-xhci.yaml     |    6 +
 drivers/usb/dwc3/core.c                       |   12 +
 drivers/usb/dwc3/core.h                       |    2 +
 drivers/usb/dwc3/host.c                       |    5 +-
 drivers/usb/host/Kconfig                      |    9 +
 drivers/usb/host/Makefile                     |    4 +
 drivers/usb/host/xhci-debugfs.c               |    2 +-
 drivers/usb/host/xhci-mem.c                   |  136 +-
 drivers/usb/host/xhci-plat.c                  |    2 +
 drivers/usb/host/xhci-ring.c                  |   53 +-
 drivers/usb/host/xhci-sideband.c              |  372 ++++
 drivers/usb/host/xhci.c                       |  114 +-
 drivers/usb/host/xhci.h                       |   18 +-
 .../sound/qcom,q6dsp-lpass-ports.h            |    1 +
 include/linux/usb/xhci-sideband.h             |   67 +
 include/sound/q6usboffload.h                  |   20 +
 include/sound/soc-usb.h                       |   51 +
 sound/soc/Makefile                            |    2 +-
 sound/soc/qcom/Kconfig                        |    4 +
 sound/soc/qcom/qdsp6/Makefile                 |    1 +
 sound/soc/qcom/qdsp6/q6afe-dai.c              |   56 +
 sound/soc/qcom/qdsp6/q6afe.c                  |  206 +-
 sound/soc/qcom/qdsp6/q6afe.h                  |   36 +-
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c      |   23 +
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h      |    1 +
 sound/soc/qcom/qdsp6/q6routing.c              |    9 +
 sound/soc/qcom/qdsp6/q6usb.c                  |  450 ++++
 sound/soc/soc-usb.c                           |  201 ++
 sound/usb/Kconfig                             |   15 +
 sound/usb/Makefile                            |    2 +-
 sound/usb/card.c                              |  123 ++
 sound/usb/card.h                              |   23 +
 sound/usb/endpoint.c                          |    1 +
 sound/usb/helper.c                            |    1 +
 sound/usb/pcm.c                               |   94 +-
 sound/usb/pcm.h                               |   11 +
 sound/usb/qcom/Makefile                       |    2 +
 sound/usb/qcom/qc_audio_offload.c             | 1867 +++++++++++++++++
 sound/usb/qcom/usb_audio_qmi_v01.c            |  892 ++++++++
 sound/usb/qcom/usb_audio_qmi_v01.h            |  162 ++
 43 files changed, 5041 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6usb.yaml
 create mode 100644 drivers/usb/host/xhci-sideband.c
 create mode 100644 include/linux/usb/xhci-sideband.h
 create mode 100644 include/sound/q6usboffload.h
 create mode 100644 include/sound/soc-usb.h
 create mode 100644 sound/soc/qcom/qdsp6/q6usb.c
 create mode 100644 sound/soc/soc-usb.c
 create mode 100644 sound/usb/qcom/Makefile
 create mode 100644 sound/usb/qcom/qc_audio_offload.c
 create mode 100644 sound/usb/qcom/usb_audio_qmi_v01.c
 create mode 100644 sound/usb/qcom/usb_audio_qmi_v01.h

